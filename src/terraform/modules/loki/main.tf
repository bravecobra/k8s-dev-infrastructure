resource "helm_release" "loki" {
  name       = "loki"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  namespace  = var.namespace
  version    = "2.5.0"
//   wait       = true
//   wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/loki-values.yaml", {
        namespace = var.namespace
    })}"
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  namespace  = var.namespace
  version    = "3.5.1"
//   wait       = true
//   wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/promtail-values.yaml", {
        namespace = var.namespace
    })}"
  ]
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    helm_release.loki,
  ]

  create_duration = "10s"
}

resource "kubectl_manifest" "loki-monitor-dashboard" {
    depends_on = [
      time_sleep.wait_10_seconds
    ]
    yaml_body = "${templatefile("${path.module}/crds/loki-monitor-dashboard.yaml",
    {
      namespace = var.namespace
    })}"
}

resource "kubectl_manifest" "loki-promtail-dashboard" {
    depends_on = [
      time_sleep.wait_10_seconds
    ]
    yaml_body = "${templatefile("${path.module}/crds/loki-promtail-dashboard.yaml",{
      namespace = var.namespace
    })}"
}
