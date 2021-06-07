resource "helm_release" "traefik" {
  name       = "traefik"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = "9.19.1"
  namespace  = var.namespace
  wait = true
  wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/traefik-values.yaml", {
        namespace = var.namespace,
        domain-name = var.domain-name,
        traefik-domain-name = var.traefik-domain-name,
        service-ip = var.service-ip
    } )}"
  ]
}

resource "kubectl_manifest" "tls-store" {
    depends_on = [
        helm_release.traefik,
    ]
    yaml_body = templatefile("${path.module}/cert-store.yaml", {
        namespace = var.namespace,
        domain-name = var.domain-name
    })
}

resource "kubectl_manifest" "http-redirect-middleware" {
    depends_on = [
        helm_release.traefik,
    ]
    yaml_body = templatefile("${path.module}/http-redirect-middleware.yaml", {
        namespace = var.namespace,
        domain-name = var.domain-name
    })
}

resource "kubectl_manifest" "traefik-cert" {
    yaml_body = templatefile("${path.module}/traefik-cert.yaml", {
        namespace = var.namespace,
        domain-name = var.domain-name
    })
}

resource "kubectl_manifest" "dashboard-ingress" {
    depends_on = [
        helm_release.traefik,
    ]
    yaml_body = templatefile("${path.module}/dashboard-ingress.yaml", {
        namespace = var.namespace,
        domain-name = var.domain-name
    })
}

resource "kubectl_manifest" "dashboard-service" {
    depends_on = [
        helm_release.traefik,
    ]
    yaml_body = templatefile("${path.module}/crds/traefik-dashboard-service.yaml", {
        namespace = var.namespace
    })
}

resource "kubectl_manifest" "traefik-grafana-dashboard" {
    depends_on = [
        helm_release.traefik,
    ]
    yaml_body = templatefile("${path.module}/crds/traefik-grafana-dashboard.yaml", {
        namespace = var.namespace
    })
}