module "metrics" {
  source       = "./modules/metrics"
  helm_release = var.metrics_helm_version
}

module "certmanager" {
  count        = var.install_cert_manager == true ? 1 : 0
  source       = "./modules/cert-manager"
  helm_release = var.cert_manager_helm_version
  depends_on = [
    module.metrics
  ]
}

module "linkerd" {
  count        = var.install_linkerd == true ? 1 : 0
  source       = "./modules/linkerd"
  helm_release = var.linkerd_helm_version
  domain-name  = var.domain-name
  depends_on = [
    module.certmanager
  ]
}

module "traefik" {
  count        = var.install_traefik == true ? 1 : 0
  source       = "./modules/traefik"
  helm_release = var.traefik_helm_version
  domain-name  = var.domain-name
  depends_on = [
    module.linkerd
  ]
}

module "jaeger" {
  count        = var.install_jaeger == true ? 1 : 0
  source       = "./modules/jaeger"
  helm_release = var.jaeger_helm_version
  domain-name  = var.domain-name
  depends_on = [
    module.linkerd
  ]
}

module "loki" {
  count                 = var.install_loki == true ? 1 : 0
  source                = "./modules/loki"
  helm_release_loki     = var.loki_helm_version
  helm_release_promtail = var.promtail_helm_version
  depends_on = [
    module.prometheus
  ]
}

module "argocd" {
  count        = var.install_argocd == true ? 1 : 0
  source       = "./modules/argocd"
  helm_release = var.argocd_helm_version
  domain-name  = var.domain-name
  depends_on = [
    module.jaeger
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
    module.jaeger
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
    module.jaeger
  ]
}

module "vault" {
  count        = var.install_vault == true ? 1 : 0
  source       = "./modules/vault"
  helm_release = var.vault_helm_version
  domain-name    = var.domain-name
  depends_on = [
    module.jaeger
  ]
}

module "coredns" {
  count              = var.install_identityserver4admin == true ? 1 : 0
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
    module.coredns
  ]
}