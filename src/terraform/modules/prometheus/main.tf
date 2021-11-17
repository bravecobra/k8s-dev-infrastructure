resource "helm_release" "prometheus" {
  name          = "prometheus"
  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "kube-prometheus-stack"
  version       = var.helm_release
  namespace     = var.namespace
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


