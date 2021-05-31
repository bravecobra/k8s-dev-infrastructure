resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = var.namespace
  }
}

module "consul" {
  source = "./modules/consul"
  domain-name =  "consul.${var.namespace}.${var.domain-name}"
  namespace = var.namespace
  datacenter = var.consul-datacenter
}

module "cert-manager" {
  source = "./modules/cert-manager"
}

module "traefik" {
  source = "./modules/traefik"
  domain-name =  "${var.domain-name}"
  traefik-domain-name = "traefik.${var.namespace}.${var.domain-name}"
  service-ip = var.service-ip
  namespace = var.namespace
  depends_on = [
    module.consul
  ]
}