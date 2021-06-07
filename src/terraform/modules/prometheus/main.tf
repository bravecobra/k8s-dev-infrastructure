resource "helm_release" "prometheus-operator" {
  name       = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = var.namespace
  version    = "16.0.1"
//   wait       = true
//   wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/prometheus-values.yaml", {
        prometheus-domain = var.prometheus-domain-name,
        namespace = var.namespace,
        grafana-domain = var.grafana-domain-name,
    })}"
  ]
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    helm_release.prometheus-operator,
  ]

  create_duration = "10s"
}

resource "kubectl_manifest" "jaeger-monitor" {
    depends_on = [
      time_sleep.wait_10_seconds
    ]
    yaml_body = file("${path.module}/crds/jaeger-monitor.yaml")
}

resource "kubectl_manifest" "traefik-monitor" {
    depends_on = [
      time_sleep.wait_10_seconds
    ]
    yaml_body = file("${path.module}/crds/traefik-monitor.yaml")
}

resource "kubectl_manifest" "traefik-rules" {
    depends_on = [
      time_sleep.wait_10_seconds
    ]
    yaml_body = file("${path.module}/crds/traefik-rules.yaml")
}

output "prometheus-url" {
  value = "https://${var.prometheus-domain-name}"
}

output "grafana-url" {
  value = "https://${var.grafana-domain-name}"
}