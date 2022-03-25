resource "kubectl_manifest" "notify_watchers" {
  yaml_body = file("./notify-watcher.yaml")
}

locals {
  patch_coredns = var.install_identityserver4admin || var.install_keycloak
}


module "metrics" {
  count        = var.install_metrics == true ? 1 : 0
  source       = "./modules/metrics"
  helm_release = var.metrics_helm_version
}

module "certmanager" {
  count        = var.install_cert_manager == true ? 1 : 0
  source       = "./modules/cert-manager"
  helm_release = var.cert_manager_helm_version
  depends_on = [
    kubernetes_namespace.cert-manager,
  ]
}

module "linkerd" {
  count        = var.install_linkerd == true ? 1 : 0
  source       = "./modules/linkerd"
  helm_release = var.linkerd_helm_version
  domain-name  = var.domain-name
  tracing_enabled = var.install_jaeger
  tracing_dataplane = var.install_jaeger
  metrics_external = var.install_prometheus
  depends_on = [
    module.certmanager,
    kubernetes_namespace.linkerd
  ]
}

module "traefik" {
  count        = var.install_traefik == true ? 1 : 0
  source       = "./modules/traefik"
  helm_release = var.traefik_helm_version
  domain-name  = var.domain-name
  install_dashboards    = var.install_prometheus
  loadbalancer-ip       = var.loadbalancer-ip
  node-ips              = var.node-ips
  depends_on = [
    module.linkerd,
    kubernetes_namespace.traefik
  ]
}

module "jaeger" {
  count        = var.install_jaeger == true ? 1 : 0
  source       = "./modules/jaeger"
  helm_release = var.jaeger_helm_version
  domain-name  = var.domain-name
  install_dashboards    = var.install_prometheus
  depends_on = [
    module.linkerd,
    kubernetes_namespace.jaeger
  ]
}

module "loki" {
  count                 = var.install_loki == true ? 1 : 0
  source                = "./modules/loki"
  helm_release_loki     = var.loki_helm_version
  helm_release_promtail = var.promtail_helm_version
  install_dashboards    = var.install_prometheus
  tracing_enabled       = var.install_jaeger
  depends_on = [
    module.prometheus,
    kubernetes_namespace.loki
  ]
}

module "argocd" {
  count        = var.install_argocd == true ? 1 : 0
  source       = "./modules/argocd"
  helm_release = var.argocd_helm_version
  domain-name  = var.domain-name
  install_dashboards    = var.install_prometheus
  depends_on = [
    module.jaeger,
    kubernetes_namespace.argocd
  ]
}

module "prometheus" {
  count          = var.install_prometheus == true ? 1 : 0
  source         = "./modules/prometheus"
  helm_release   = var.prometheus_helm_version
  metrics_jaeger = var.install_jaeger
  metrics_loki   = var.install_loki
  metrics_argocd = var.install_argocd
  domain-name    = var.domain-name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.prometheus
  ]
}


module "elasticsearch" {
  count                 = var.install_elasticsearch == true ? 1 : 0
  source                = "./modules/elasticsearch"
  helm_release          = var.elasticsearch_helm_version
  install_elasticsearch = var.install_elasticsearch
  install_kibana        = var.install_kibana
  domain-name           = var.domain-name
  depends_on = [
    module.jaeger,
    kubernetes_namespace.elasticsearch
  ]
}

module "vault" {
  count        = var.install_vault == true ? 1 : 0
  source       = "./modules/vault"
  helm_release = var.vault_helm_version
  domain-name    = var.domain-name
  depends_on = [
    module.jaeger,
    kubernetes_namespace.vault
  ]
}

module "coredns" {
  count              = local.patch_coredns == true ? 1 : 0
  source             = "./modules/coredns"
  domain-name        = var.domain-name
  depends_on = [
    module.jaeger
  ]
}

module "identityserver4" {
  count              = var.install_identityserver4admin == true ? 1 : 0
  source             = "./modules/identityserver4-admin"
  helm_release       = var.identityserver4admin_helm_version
  mssql_helm_release = var.mssql_helm_version
  domain-name        = var.domain-name
  depends_on = [
    module.jaeger,
    module.coredns,
    kubernetes_namespace.identityserver4
  ]
}

module "seq" {
  count              = var.install_seq == true ? 1 : 0
  source             = "./modules/seq"
  helm_release       = var.seq_helm_version
  fluent_helm_release = var.fluent_helm_version
  domain-name        = var.domain-name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.seq
  ]
}

module "keycloak" {
  count              = var.install_keycloak == true ? 1 : 0
  source             = "./modules/keycloak"
  helm_release       = var.keycloak_helm_version
  domain-name        = var.domain-name
  forward_client_secret = var.forward_client_secret
  depends_on = [
    module.coredns,
    kubernetes_namespace.keycloak
  ]
}

module "whoami" {
  count              = var.install_whoami == true ? 1 : 0
  source             = "./modules/whoami"
  helm_release       = var.whoami_helm_version
  domain-name        = var.domain-name
  depends_on = [
    module.coredns,
    kubernetes_namespace.whoami
  ]
}
