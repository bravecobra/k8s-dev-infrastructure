resource "kubectl_manifest" "notify_watchers" {
  count     = var.install_identityserver4admin == true ? 1 : 0
  yaml_body = file("./templates/notify-watcher.yaml")
}

locals {
  patch_coredns = var.install_identityserver4admin || var.install_keycloak || var.install_minio
}


module "metrics" {
  count        = var.install_metrics == true ? 1 : 0
  source       = "./modules/monitoring/metrics/metrics"
  helm_release = var.metrics_helm_version
}

module "certmanager" {
  count        = var.install_cert_manager == true ? 1 : 0
  source       = "./modules/networking/cert-manager"
  helm_release = var.cert_manager_helm_version
  namespace    = kubernetes_namespace.cert-manager[0].metadata[0].name
  depends_on = [
    kubernetes_namespace.cert-manager,
  ]
}

module "linkerd" {
  count             = var.install_linkerd == true ? 1 : 0
  source            = "./modules/networking/linkerd"
  helm_release      = var.linkerd_helm_version
  domain-name       = var.domain-name
  namespace         = kubernetes_namespace.linkerd[0].metadata[0].name
  tracing_enabled   = var.install_jaeger
  tracing_dataplane = var.install_jaeger
  metrics_external  = var.install_prometheus
  depends_on = [
    module.certmanager,
    kubernetes_namespace.linkerd
  ]
}

module "traefik" {
  count                = var.install_traefik == true ? 1 : 0
  source               = "./modules/networking/traefik"
  helm_release         = var.traefik_helm_version
  domain-name          = var.domain-name
  namespace            = kubernetes_namespace.traefik[0].metadata[0].name
  install_dashboards   = var.install_prometheus
  loadbalancer-ip      = var.loadbalancer-ip
  node-ips             = var.node-ips
  use_metrics          = var.install_prometheus
  use_tracing          = var.install_jaeger
  cluster-type         = var.cluster-type
  expose_azurite       = var.expose_azurite
  expose_seq           = var.expose_seq
  expose_opentelemetry = var.expose_opentelemetry
  expose_loki          = var.expose_loki
  expose_jaeger        = var.expose_jaeger
  expose_rabbitmq      = var.expose_rabbitmq
  expose_mysql         = var.expose_mysql
  expose_postgres      = var.expose_postgres
  expose_mssql         = var.expose_mssql
  expose_mariadb       = var.expose_mariadb
  expose_mongodb       = var.expose_mongodb
  expose_kafka         = var.expose_kafka
  expose_oracle        = var.expose_oracle
  expose_redis         = var.expose_redis
  depends_on = [
    module.linkerd,
    kubernetes_namespace.traefik
  ]
}

module "jaeger" {
  count              = var.install_jaeger == true ? 1 : 0
  source             = "./modules/monitoring/tracing/jaeger"
  helm_release       = var.jaeger_helm_version
  domain-name        = var.domain-name
  install_dashboards = var.install_prometheus
  namespace          = kubernetes_namespace.jaeger[0].metadata[0].name
  depends_on = [
    module.linkerd,
    kubernetes_namespace.jaeger
  ]
}

module "opentelemetry" {
  count            = var.install_opentelemetry == true ? 1 : 0
  source           = "./modules/monitoring/ingestion/opentelemetry"
  helm_release     = var.opentelemetry_helm_version
  expose_ingestion = var.expose_opentelemetry
  namespace        = kubernetes_namespace.opentelemetry[0].metadata[0].name
  install_jaeger   = var.install_jaeger
  install_loki     = var.install_loki
  # domain-name  = var.domain-name
  # install_dashboards    = var.install_prometheus
  depends_on = [
    module.linkerd,
    kubernetes_namespace.opentelemetry
  ]
}

module "loki" {
  count                 = var.install_loki == true ? 1 : 0
  source                = "./modules/monitoring/logging/loki"
  helm_release_loki     = var.loki_helm_version
  helm_release_promtail = var.promtail_helm_version
  install_dashboards    = var.install_prometheus
  install_promtail      = var.install_promtail
  tracing_enabled       = var.install_jaeger
  expose_ingestion      = var.expose_loki
  namespace             = kubernetes_namespace.loki[0].metadata[0].name
  depends_on = [
    module.prometheus,
    kubernetes_namespace.loki
  ]
}

module "argocd" {
  count              = var.install_argocd == true ? 1 : 0
  source             = "./modules/services/deployment/argocd"
  helm_release       = var.argocd_helm_version
  domain-name        = var.domain-name
  install_prometheus = var.install_prometheus
  namespace          = kubernetes_namespace.argocd[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.argocd
  ]
}

module "tempo" {
  count        = var.install_tempo == true ? 1 : 0
  source       = "./modules/monitoring/tracing/tempo"
  helm_release = var.tempo_helm_version
  namespace    = kubernetes_namespace.tempo[0].metadata[0].name
  depends_on = [
    module.linkerd,
    kubernetes_namespace.tempo
  ]
}

module "prometheus" {
  count              = var.install_prometheus == true || var.install_grafana == true ? 1 : 0
  source             = "./modules/monitoring/metrics/prometheus"
  helm_release       = var.prometheus_helm_version
  install_prometheus = var.install_prometheus
  install_grafana    = var.install_grafana
  metrics_jaeger     = var.install_jaeger
  metrics_loki       = var.install_loki
  metrics_argocd     = var.install_argocd
  metrics_minio      = var.install_minio
  metrics_linkerd    = var.install_linkerd
  metrics_rabbitmq   = var.install_rabbitmq
  metrics_tempo      = var.install_tempo
  domain-name        = var.domain-name
  namespace          = kubernetes_namespace.prometheus[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.prometheus
  ]
}


module "elasticsearch" {
  count                 = var.install_elasticsearch == true ? 1 : 0
  source                = "./modules/services/search/elasticsearch"
  helm_release          = var.elasticsearch_helm_version
  install_elasticsearch = var.install_elasticsearch
  install_kibana        = var.install_kibana
  domain-name           = var.domain-name
  namespace             = kubernetes_namespace.elasticsearch[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.elasticsearch
  ]
}

module "vault" {
  count        = var.install_vault == true ? 1 : 0
  source       = "./modules/services/configuration/vault"
  helm_release = var.vault_helm_version
  domain-name  = var.domain-name
  namespace    = kubernetes_namespace.vault[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.vault
  ]
}

module "coredns" {
  count       = local.patch_coredns == true ? 1 : 0
  source      = "./modules/networking/coredns"
  domain-name = var.domain-name
  depends_on = [
    module.jaeger
  ]
}

module "identityserver4" {
  count              = var.install_identityserver4admin == true ? 1 : 0
  source             = "./modules/services/security/auth/identityserver4-admin"
  helm_release       = var.identityserver4admin_helm_version
  mssql_helm_release = var.identityserver4admin_mssql_helm_version
  domain-name        = var.domain-name
  namespace          = kubernetes_namespace.identityserver4[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.coredns,
    module.linkerd,
    kubernetes_namespace.identityserver4
  ]
}

module "seq" {
  count               = var.install_seq == true ? 1 : 0
  source              = "./modules/monitoring/logging/seq"
  helm_release        = var.seq_helm_version
  fluent_helm_release = var.fluent_helm_version
  domain-name         = var.domain-name
  expose_ingestion    = var.expose_seq
  namespace           = kubernetes_namespace.seq[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.seq
  ]
}

module "keycloak" {
  count        = var.install_keycloak == true ? 1 : 0
  source       = "./modules/services/security/auth/keycloak"
  helm_release = var.keycloak_helm_version
  domain-name  = var.domain-name
  namespace    = kubernetes_namespace.keycloak[0].metadata[0].name
  //forward_client_secret = var.forward_client_secret
  include_domainrealm = var.keycloak_include_domainrealm
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.keycloak
  ]
}

module "whoami" {
  count        = var.install_whoami == true ? 1 : 0
  source       = "./samples/whoami"
  helm_release = var.whoami_helm_version
  domain-name  = var.domain-name
  namespace    = kubernetes_namespace.whoami[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.whoami
  ]
}

module "minio" {
  count        = var.install_minio == true ? 1 : 0
  source       = "./modules/services/storage/minio"
  helm_release = var.minio_helm_version
  domain-name  = var.domain-name
  metrics      = var.install_prometheus
  namespace    = kubernetes_namespace.minio[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.minio
  ]
}

module "etcd" {
  count        = var.install_etcd == true ? 1 : 0
  source       = "./modules/services/configuration/etcd"
  helm_release = var.etcd_helm_version
  domain-name  = var.domain-name
  namespace    = kubernetes_namespace.etcd[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.etcd
  ]
}

module "azurite" {
  count           = var.install_azurite == true ? 1 : 0
  source          = "./modules/services/storage/azurite"
  domain-name     = var.domain-name
  azurite_version = var.azurite_version
  namespace       = kubernetes_namespace.azurite[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.azurite
  ]
}

module "rabbitmq" {
  count              = var.install_rabbitmq == true ? 1 : 0
  source             = "./modules/services/messaging/rabbitmq"
  domain-name        = var.domain-name
  helm_release       = var.rabbitmq_helm_version
  install_dashboards = var.install_prometheus
  namespace          = kubernetes_namespace.rabbitmq[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.rabbitmq
  ]
}

module "localstack" {
  count        = var.install_localstack == true ? 1 : 0
  source       = "./modules/services/cloud/localstack"
  domain-name  = var.domain-name
  helm_release = var.localstack_helm_version
  namespace    = kubernetes_namespace.localstack[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.localstack
  ]
}

module "flux2" {
  count                 = var.install_flux2 == true ? 1 : 0
  source                = "./modules/services/deployment/flux2"
  repository_name       = var.flux2_github_repository_name
  target_path           = var.flux2_github_repository_path
  repository_create     = var.flux2_github_repository_create
  repository_visibility = var.flux2_github_repository_visibility
  branch                = var.flux2_github_repository_branch
  domain-name           = var.domain-name
  namespace             = kubernetes_namespace.flux_system[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.flux_system
  ]
}

module "mysql" {
  count        = var.install_mysql == true ? 1 : 0
  source       = "./modules/services/database/rds/mysql"
  domain-name  = var.domain-name
  helm_release = var.mysql_helm_version
  expose_mysql = var.expose_mysql
  namespace    = kubernetes_namespace.mysql[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.mysql
  ]
}

module "postgres" {
  count           = var.install_postgres == true ? 1 : 0
  source          = "./modules/services/database/rds/postgres"
  domain-name     = var.domain-name
  helm_release    = var.postgres_helm_version
  expose_postgres = var.expose_postgres
  namespace       = kubernetes_namespace.postgres[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.postgres
  ]
}

module "mssql" {
  count        = var.install_mssql == true ? 1 : 0
  source       = "./modules/services/database/rds/sqlserver"
  domain-name  = var.domain-name
  helm_release = var.mssql_helm_version
  expose_mssql = var.expose_mssql
  namespace    = kubernetes_namespace.mssql[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.mssql
  ]
}

module "mariadb" {
  count          = var.install_mariadb == true ? 1 : 0
  source         = "./modules/services/database/rds/mariadb"
  domain-name    = var.domain-name
  helm_release   = var.mariadb_helm_version
  expose_mariadb = var.expose_mariadb
  namespace      = kubernetes_namespace.mariadb[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.mariadb
  ]
}

module "mongodb" {
  count          = var.install_mongodb == true ? 1 : 0
  source         = "./modules/services/database/nosql/mongodb"
  domain-name    = var.domain-name
  helm_release   = var.mongodb_helm_version
  expose_mongodb = var.expose_mongodb
  namespace      = kubernetes_namespace.mongodb[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.mongodb
  ]
}

data "http" "manifestfiles" {
  //count = var.install_oracle == true ? 1 : 0
  url = "https://raw.githubusercontent.com/oracle/oracle-database-operator/${var.oracle_operator_version}/oracle-database-operator.yaml"
}

data "kubectl_file_documents" "oracle_manifests" {
  //count   = var.install_oracle == true ? 1 : 0
  content = data.http.manifestfiles.response_body
}

module "oraclexe" {
  count       = var.install_oracle == true ? 1 : 0
  source      = "./modules/services/database/rds/oracle-xe"
  domain-name = var.domain-name
  # helm_release   = var.mongodb_helm_version
  expose_oracle           = var.expose_oracle
  oracle_operator_version = var.oracle_operator_version
  oracle_xe_version       = var.oracle_xe_version
  manifestfiles           = data.kubectl_file_documents.oracle_manifests.manifests
  namespace               = kubernetes_namespace.oracle[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    module.certmanager,
    kubernetes_namespace.oracle
  ]
}

module "redis" {
  count        = var.install_redis == true ? 1 : 0
  source       = "./modules/services/caching/redis"
  domain-name  = var.domain-name
  helm_release = var.redis_helm_version
  namespace    = kubernetes_namespace.redis[0].metadata[0].name
  expose_redis = var.expose_redis
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.redis
  ]
}

module "kafka" {
  count        = var.install_kafka == true ? 1 : 0
  source       = "./modules/services/messaging/kafka"
  domain-name  = var.domain-name
  helm_release = var.kafka_helm_version
  expose_kafka = var.expose_kafka
  namespace    = kubernetes_namespace.kafka[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.kafka
  ]
}
