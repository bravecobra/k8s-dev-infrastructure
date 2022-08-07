resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "prometheus" {
  name          = "prometheus"
  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "kube-prometheus-stack"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/prometheus-values.yaml", {
      domain-name = var.domain-name,
      grafana_password = random_password.init_password.result,
      install_prometheus = var.install_prometheus,
      install_grafana = var.install_grafana,
      metrics_linkerd  = var.metrics_linkerd,
      metrics_minio    = var.metrics_minio,
      metrics_loki     = var.metrics_loki,
      metrics_tempo    = var.metrics_tempo,
    })
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "jaeger_monitor" {
  count     = var.metrics_jaeger ? 1 : 0
  yaml_body = file("${path.module}/templates/jaeger-monitor.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "traefik-monitor" {
  yaml_body = file("${path.module}/templates/traefik-monitor.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "traefik-rules" {
  yaml_body = file("${path.module}/templates/traefik-rules.yaml")
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "rabbitmq-monitor" {
  count     = var.metrics_rabbitmq ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/rabbitmq-monitor.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubectl_manifest" "prometheus-cert" {
  yaml_body = templatefile("${path.module}/templates/prometheus-cert.yaml", {
    domain-name = var.domain-name
  })
  depends_on = [
    helm_release.prometheus
  ]
}


