resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
    annotations = {
      "kubernetes.io/description" = "Prometheus"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "prometheus" {
  name          = "prometheus"
  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "kube-prometheus-stack"
  version       = var.helm_release
  namespace     = kubernetes_namespace.prometheus.metadata.0.name
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/prometheus-values.yaml", {domain-name = var.domain-name})
  ]
}

resource "kubectl_manifest" "jaeger_monitor" {
  count     = var.metrics_jaeger ? 1 : 0
  yaml_body = file("${path.module}/crds/jaeger-monitor.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "jaeger_dashboard" {
  count     = var.metrics_jaeger ? 1 : 0
  yaml_body = file("${path.module}/crds/dashboards/jaeger/jaeger-grafana-dashboard.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "loki_dashboard" {
  count     = var.metrics_loki ? 1 : 0
  yaml_body = file("${path.module}/crds/dashboards/loki/loki-monitor-dashboard.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "argocd_dashboard" {
  count     = var.metrics_argocd ? 1 : 0
  yaml_body = file("${path.module}/crds/dashboards/argocd/argocd-grafana-dashboard.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "promtail_dashboard" {
  count     = var.metrics_loki ? 1 : 0
  yaml_body = file("${path.module}/crds/dashboards/loki/loki-promtail-dashboard.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "traefik-monitor" {
  yaml_body = file("${path.module}/crds/traefik-monitor.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "traefik-rules" {
  yaml_body = file("${path.module}/crds/traefik-rules.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "prometheus-cert" {
  yaml_body = templatefile("${path.module}/crds/prometheus-cert.yaml", {domain-name = var.domain-name})
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "traefik_dashboard" {
  yaml_body = file("${path.module}/crds/dashboards/traefik/traefik-grafana-dashboard.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}
