resource "kubernetes_namespace" "jaeger" {
  metadata {
    name = "jaeger"
    annotations = {
      "kubernetes.io/description" = "Jaeger"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "jaeger" {
  name       = "jaeger"
  chart      = "jaeger-operator"
  repository = "https://jaegertracing.github.io/helm-charts"
  version    = var.helm_release
  namespace  = kubernetes_namespace.jaeger.metadata.0.name
  values = [
    "${file("${path.module}/jaeger-values.yaml")}"
  ]
}

resource "kubectl_manifest" "all-in-one" {
  yaml_body = templatefile("${path.module}/crds/all-in-one.yaml", {domain-name = var.domain-name})
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "admin-service" {
  yaml_body = file("${path.module}/crds/jaeger-admin-service.yaml")
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "jaeger-cert" {
  yaml_body = templatefile("${path.module}/crds/jaeger-cert.yaml", {domain-name = var.domain-name})
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "upd-ingress" {
  yaml_body = file("${path.module}/crds/udp-ingress.yaml")
  depends_on = [
    helm_release.jaeger
  ]
}