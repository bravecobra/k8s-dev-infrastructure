resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
    annotations = {
      "kubernetes.io/description" = "Loki"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "loki" {
  name       = "loki"
  chart      = "loki"
  namespace  = kubernetes_namespace.loki.metadata.0.name
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_loki
  values = [
    "${file("${path.module}/loki-values.yaml")}"
  ]
  depends_on = [
    kubernetes_namespace.loki
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  chart      = "promtail"
  namespace  = kubernetes_namespace.loki.metadata.0.name
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_promtail
  values = [
    "${file("${path.module}/promtail-values.yaml")}"
  ]

resource "kubectl_manifest" "promtail_dashboard" {
  count     = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/loki/loki-promtail-dashboard.yaml")
  depends_on = [
    helm_release.promtail
  ]
}

resource "kubectl_manifest" "loki_dashboard" {
  count     = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/loki/loki-monitor-dashboard.yaml")
  depends_on = [
    helm_release.loki
  ]
}