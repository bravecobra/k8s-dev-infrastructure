resource "helm_release" "loki" {
  name       = "loki"
  chart      = "loki"
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_loki
  values = [
    templatefile("${path.module}/loki-values.yaml", { tracing = var.tracing_enabled })
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  chart      = "promtail"
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_promtail
  values = [
    "${file("${path.module}/promtail-values.yaml")}"
  ]
}

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

resource "kubectl_manifest" "loki_ingestion" {
  count       = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/loki-ingestion-route.yaml", {
      namespace = var.namespace
  })
  depends_on = [
      helm_release.loki
  ]
}