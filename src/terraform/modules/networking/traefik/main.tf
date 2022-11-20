resource "kubectl_manifest" "traefik-cert" {
  yaml_body = templatefile("${path.module}/templates/traefik-cert.yaml", { domain-name = var.domain-name })
}


resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = var.namespace
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = var.helm_release
  values = [
    templatefile("${path.module}/traefik-values.yaml", {
      domain-name          = var.domain-name
      loadbalancer-ip      = var.loadbalancer-ip
      node-ips             = var.node-ips
      cluster-type         = var.cluster-type
      use_metrics          = var.use_metrics
      use_tracing          = var.use_tracing
      expose_azurite       = var.expose_azurite
      expose_seq           = var.expose_seq
      expose_opentelemetry = var.expose_opentelemetry
      expose_loki          = var.expose_loki
      expose_rabbitmq      = var.expose_rabbitmq
      expose_jaeger        = var.expose_jaeger
      expose_mysql         = var.expose_mysql
      expose_postgres      = var.expose_postgres
      expose_mssql         = var.expose_mssql
      expose_mariadb       = var.expose_mariadb
      expose_mongodb       = var.expose_mongodb
      expose_oracle        = var.expose_oracle
      expose_redis         = var.expose_redis
    })
  ]
  depends_on = [
    kubectl_manifest.traefik-cert
  ]
}

resource "kubectl_manifest" "cert-store" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = file("${path.module}/templates/cert-store.yaml")
}

resource "kubectl_manifest" "dashboard" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = templatefile("${path.module}/templates/dashboard.yaml", { domain-name = var.domain-name })
}

resource "kubectl_manifest" "http-redirect-middleware" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = file("${path.module}/templates/http-redirect-middleware.yaml")
}

resource "kubectl_manifest" "traefik-metrics-service" {
  count     = var.use_metrics ? 1 : 0
  yaml_body = file("${path.module}/templates/traefik-metrics-service.yaml")
  depends_on = [
    helm_release.traefik
  ]
}

resource "kubectl_manifest" "traefik_dashboard" {
  count     = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/traefik/traefik-grafana-dashboard.yaml")
  depends_on = [
    helm_release.traefik
  ]
}