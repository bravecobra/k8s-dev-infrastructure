resource "kubectl_manifest" "traefik-cert" {
  yaml_body = templatefile("${path.module}/traefik-cert.yaml", {domain-name = var.domain-name})
}


resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = var.namespace
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = var.helm_release
  values = [
    templatefile("${path.module}/traefik-values.yaml", {
      domain-name = var.domain-name,
      loadbalancer-ip = var.loadbalancer-ip
      node-ips = var.node-ips
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
  yaml_body = file("${path.module}/cert-store.yaml")
}

resource "kubectl_manifest" "dashboard" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = templatefile("${path.module}/dashboard.yaml", {domain-name = var.domain-name})
}

resource "kubectl_manifest" "http-redirect-middleware" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = file("${path.module}/http-redirect-middleware.yaml")
}

resource "kubectl_manifest" "traefik-metrics-service" {
  depends_on = [
    helm_release.traefik
  ]
  yaml_body = file("${path.module}/traefik-metrics-service.yaml")
}

resource "kubectl_manifest" "traefik_dashboard" {
  count        = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/traefik/traefik-grafana-dashboard.yaml")
  depends_on = [
    helm_release.traefik
  ]
}