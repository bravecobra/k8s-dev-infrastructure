resource "helm_release" "jaeger" {
  name       = "jaeger"
  chart      = "jaeger-operator"
  repository = "https://jaegertracing.github.io/helm-charts"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    "${file("${path.module}/jaeger-values.yaml")}"
  ]
}

resource "kubectl_manifest" "all-in-one" {
  yaml_body = templatefile("${path.module}/templates/all-in-one.yaml", { domain-name = var.domain-name })
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "admin-service" {
  yaml_body = file("${path.module}/templates/jaeger-admin-service.yaml")
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "jaeger-cert" {
  yaml_body = templatefile("${path.module}/templates/jaeger-cert.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "jaeger_dashboard" {
  count     = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/jaeger/jaeger-grafana-dashboard.yaml")
  depends_on = [
    helm_release.jaeger
  ]
}

resource "kubectl_manifest" "upd-ingress" {
  yaml_body = file("${path.module}/templates/udp-ingress.yaml")
  depends_on = [
    helm_release.jaeger
  ]
}