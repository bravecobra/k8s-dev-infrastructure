resource "kubectl_manifest" "linkerd-cert" {
  yaml_body = file("${path.module}/templates/linkerd-cert.yaml")
}

resource "kubectl_manifest" "linkerd-identity-cert" {
  yaml_body = file("${path.module}/templates/linkerd-identity-cert.yaml")
}

resource "kubectl_manifest" "linkerd-trust-anchor-cert" {
  yaml_body = file("${path.module}/templates/linkerd-trust-anchor-cert.yaml")
}

resource "kubectl_manifest" "linkerd-trust-anchor-issuer" {
  yaml_body = file("${path.module}/templates/linkerd-trust-anchor-issuer.yaml")
}

resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    kubectl_manifest.linkerd-identity-cert
  ]
  create_duration = "50s"
}

resource "null_resource" "fetch_ca" {
  provisioner "local-exec" {
    command = "kubectl get secret linkerd-identity-issuer -n linkerd -o jsonpath=\"{.data.tls\\.crt}\" | base64 -d > ./modules/networking/linkerd/ca.crt"
  }
  depends_on = [
    time_sleep.wait_x_seconds
  ]
}

data "local_file" "ca-cert" {
  filename   = "${path.module}/ca.crt"
  depends_on = [null_resource.fetch_ca]
}

resource "helm_release" "linkerd" {
  name          = "linkerd"
  chart         = "linkerd2"
  namespace     = var.namespace
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
  namespace     = var.namespace
  version       = var.helm_release
  repository    = "https://helm.linkerd.io/stable"
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/linkerd-viz-values.yaml", {
      tracing          = var.tracing_enabled,
      metrics_external = var.metrics_external
    })
  ]
  depends_on = [
    helm_release.linkerd
  ]
}

resource "kubectl_manifest" "linkerd-viz-ingress-secret" {
  depends_on = [
    helm_release.linkerd-viz
  ]
  yaml_body = file("${path.module}/templates/ingress-secret.yaml")
}

resource "kubectl_manifest" "linkerd-viz-ingress" {
  depends_on = [
    helm_release.linkerd-viz
  ]
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", { domain-name = var.domain-name })
}

# TODO only install jaeger in install_jaeger is enabled

resource "helm_release" "linkerd-jaeger" {
  count         = var.tracing_enabled == true && (var.tracing_controlplane || var.tracing_dataplane) ? 1 : 0
  name          = "linkerd-jaeger"
  chart         = "linkerd-jaeger"
  namespace     = var.namespace
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