resource "kubernetes_namespace" "linkerd" {
  metadata {
    name = "linkerd"
    annotations = {
      "kubernetes.io/description"   = "Linkerd"
      "linkerd.io/inject"           = "disabled"
      "linkerd.io/control-plane-ns" = "linkerd"
      "linkerd.io/is-control-plane" = "true"
    }
    labels = {
      "config.linkerd.io/admission-webhooks" = "disabled"
    }
  }
}

resource "kubectl_manifest" "linkerd-cert" {
  depends_on = [
    kubernetes_namespace.linkerd
  ]
  yaml_body = file("${path.module}/linkerd-cert.yaml")
}

resource "kubectl_manifest" "linkerd-identity-cert" {
  depends_on = [
    kubernetes_namespace.linkerd
  ]
  yaml_body = file("${path.module}/linkerd-identity-cert.yaml")
}

resource "kubectl_manifest" "linkerd-trust-anchor-cert" {
  depends_on = [
    kubernetes_namespace.linkerd
  ]
  yaml_body = file("${path.module}/linkerd-trust-anchor-cert.yaml")
}

resource "kubectl_manifest" "linkerd-trust-anchor-issuer" {
  depends_on = [
    kubernetes_namespace.linkerd
  ]
  yaml_body = file("${path.module}/linkerd-trust-anchor-issuer.yaml")
}

resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    kubectl_manifest.linkerd-identity-cert
  ]
  create_duration = "50s"
}

resource "null_resource" "fetch_ca" {
  provisioner "local-exec" {
    command = "kubectl get secret linkerd-identity-issuer -n linkerd -o jsonpath=\"{.data.tls\\.crt}\" | base64 -d > ./modules/linkerd/ca.crt"
  }
  depends_on = [
    time_sleep.wait_x_seconds
  ]
}

data "local_file" "ca-cert" {
  filename   = "${path.module}/ca.crt"
  depends_on = [null_resource.fetch_ca]
}

output "ca-cert" {
  description = "CA certificate"
  value       = data.local_file.ca-cert.content
}

#TODO forward to local prometheus if install_prometheus is true

resource "helm_release" "linkerd" {
  name          = "linkerd"
  chart         = "linkerd2"
  namespace     = "linkerd"
  repository    = "https://helm.linkerd.io/stable"
  version       = var.helm_release
  wait          = true
  wait_for_jobs = true
  set {
    name  = "identityTrustAnchorsPEM"
    value = data.local_file.ca-cert.content
  }
  set {
    name  = "identity.issuer.scheme"
    value = "kubernetes.io/tls"
  }
  set {
    name  = "installNamespace"
    value = "false"
  }
  values = [
    "${file("${path.module}/linkerd-values.yaml")}"
  ]

  depends_on = [
    null_resource.fetch_ca,
  ]
}

resource "helm_release" "linkerd-viz" {
  name          = "linkerd-viz"
  chart         = "linkerd-viz"
  namespace     = "linkerd"
  version       = var.helm_release
  repository    = "https://helm.linkerd.io/stable"
  wait          = true
  wait_for_jobs = true
  values = [
    "${file("${path.module}/linkerd-viz-values.yaml")}"
  ]
  depends_on = [
    helm_release.linkerd
  ]
}

resource "kubectl_manifest" "linkerd-viz-ingress-secret" {
  depends_on = [
    helm_release.linkerd-viz
  ]
  yaml_body = file("${path.module}/ingress-secret.yaml")
}

resource "kubectl_manifest" "linkerd-viz-ingress" {
  depends_on = [
    helm_release.linkerd-viz
  ]
  yaml_body = templatefile("${path.module}/ingress.yaml", {domain-name = var.domain-name})
}

# TODO only install jaeger in install_jaeger is enabled

resource "helm_release" "linkerd-jaeger" {
  name          = "linkerd-jaeger"
  chart         = "linkerd-jaeger"
  namespace     = "linkerd"
  version       = var.helm_release
  repository    = "https://helm.linkerd.io/stable"
  wait          = true
  wait_for_jobs = true
  values = [
    "${file("${path.module}/linkerd-jaeger-values.yaml")}"
  ]
  depends_on = [
    helm_release.linkerd
  ]
}