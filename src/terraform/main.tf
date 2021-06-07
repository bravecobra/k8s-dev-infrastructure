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
  depends_on = [
    kubernetes_namespace.infrastructure
  ]
}

module "cert-manager" {
  source = "./modules/cert-manager"
}

module "consul-coredns" {
  source = "./modules/consul-coredns"
  namespace = var.namespace
  depends_on = [
    module.consul
  ]
}

module "traefik" {
  source = "./modules/traefik"
  domain-name =  "${var.domain-name}"
  traefik-domain-name = "traefik.${var.namespace}.${var.domain-name}"
  service-ip = var.service-ip
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "prometheus" {
  source = "./modules/prometheus"
  prometheus-domain-name =  "prometheus.${var.namespace}.${var.domain-name}"
  grafana-domain-name =  "grafana.${var.namespace}.${var.domain-name}"
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "loki" {
  source = "./modules/loki"
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "jaeger" {
  source = "./modules/jaeger"
  namespace = var.namespace
  jaeger-domain-name = "jaeger.${var.namespace}.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "elasticsearch" {
  source = "./modules/elasticsearch"
  namespace = var.namespace
  elastic-domain-name = "es.${var.namespace}.${var.domain-name}"
  kibana-domain-name = "kibana.${var.namespace}.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "identityserver4" {
  source = "./modules/identityserver4admin"
  namespace = var.namespace
  login-domain-name = "login.${var.domain-name}"
  admin-domain-name = "admin.login.${var.domain-name}"
  api-domain-name = "api.login.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}