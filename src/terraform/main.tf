resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = var.namespace
  }
}

module "consul" {
  source = "./modules/consul"
  count = var.install_consul == true ? 1 : 0
  domain-name =  "consul.${var.namespace}.${var.domain-name}"
  namespace = var.namespace
  datacenter = var.consul-datacenter
  depends_on = [
    kubernetes_namespace.infrastructure
  ]
}

output "consul-url" {
  value = var.install_consul == true ? module.consul.0.consul-url : null
}

module "cert-manager" {
  count = var.install_cert_manager == true ? 1 : 0
  source = "./modules/cert-manager"
}

module "consul-coredns" {
  source = "./modules/consul-coredns"
  count = var.patch_coredns == true ? 1 : 0
  namespace = var.namespace
  depends_on = [
    module.consul
  ]
}

module "traefik" {
  source = "./modules/traefik"
  count = var.install_traefik == true ? 1 : 0
  domain-name =  "${var.domain-name}"
  traefik-domain-name = "traefik.${var.namespace}.${var.domain-name}"
  service-ip = var.service-ip
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

output "traefik-url" {
  value = var.install_traefik == true ? module.traefik.0.traefik-url : null
}

module "prometheus" {
  source = "./modules/prometheus"
  count = var.install_prometheus == true ? 1 : 0
  prometheus-domain-name =  "prometheus.${var.namespace}.${var.domain-name}"
  grafana-domain-name =  "grafana.${var.namespace}.${var.domain-name}"
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

output "prometheus-url" {
  value = var.install_prometheus == true ? module.prometheus.0.prometheus-url : null
}

output "grafana-url" {
  value = var.install_prometheus == true ? module.prometheus.0.grafana-url : null
}

module "loki" {
  source = "./modules/loki"
  count = var.install_loki == true ? 1 : 0
  namespace = var.namespace
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

module "jaeger" {
  source = "./modules/jaeger"
  count = var.install_jaeger == true ? 1 : 0
  namespace = var.namespace
  jaeger-domain-name = "jaeger.${var.namespace}.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

output "jaeger-url" {
  value = var.install_jaeger == true ? module.jaeger.0.jaeger-url : null
}

module "elasticsearch" {
  source = "./modules/elasticsearch"
  count = var.install_elasticsearch == true ? 1 : 0
  namespace = var.namespace
  elastic-domain-name = "es.${var.namespace}.${var.domain-name}"
  kibana-domain-name = "kibana.${var.namespace}.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

output "elastic-url" {
  value = var.install_elasticsearch == true ? module.elasticsearch.0.elastic-url : null
}

output "kibana-url" {
  value = var.install_elasticsearch == true ? module.elasticsearch.0.kibana-url : null
}

output "elasticsearch-user" {
  value = var.install_elasticsearch == true ? module.elasticsearch.0.elastic-user : null
  sensitive = true
}

module "identityserver4" {
  source = "./modules/identityserver4admin"
  count = var.install_identityserver4admin == true ? 1 : 0
  namespace = var.namespace
  login-domain-name = "login.${var.domain-name}"
  admin-domain-name = "admin.login.${var.domain-name}"
  api-domain-name = "api.login.${var.domain-name}"
  depends_on = [
    module.consul,
    module.cert-manager
  ]
}

output "login-url" {
  value = var.install_identityserver4admin == true ? module.identityserver4.0.login-url : null
}

output "login-admin-url" {
  value = var.install_identityserver4admin == true ? module.identityserver4.0.admin-url : null
}

output "login-api-url" {
  value = var.install_identityserver4admin == true ? module.identityserver4.0.api-url : null
}