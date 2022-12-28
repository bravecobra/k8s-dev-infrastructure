resource "kubectl_manifest" "notify_watchers" {
  count     = var.install_identityserver4admin == true ? 1 : 0
  yaml_body = file("./templates/notify-watcher.yaml")
}

locals {
  patch_coredns        = var.install_identityserver4admin || var.install_keycloak || var.install_minio
  cluster_storageclass = var.cluster-type == "k3s" ? "local-path" : "standard"
  chart_version_variables = {
    "traefik"                    = { chart_version = var.traefik_helm_version },
    "cert_manager"               = { chart_version = var.cert_manager_helm_version },
    "metrics"                    = { chart_version = var.metrics_helm_version },
    "linkerd"                    = { chart_version = var.linkerd_helm_version },
    "linkerdcrds"                = { chart_version = var.linkerdcrds_helm_version },
    "linkerdviz"                 = { chart_version = var.linkerdviz_helm_version },
    "linkerdjaeger"              = { chart_version = var.linkerdjaeger_helm_version },
    "prometheus"                 = { chart_version = var.prometheus_helm_version },
    "jaeger"                     = { chart_version = var.jaeger_helm_version },
    "opentelemetry"              = { chart_version = var.opentelemetry_helm_version },
    "loki"                       = { chart_version = var.loki_helm_version },
    "promtail"                   = { chart_version = var.promtail_helm_version },
    "tempo"                      = { chart_version = var.tempo_helm_version },
    "argocd"                     = { chart_version = var.argocd_helm_version },
    "elasticsearch"              = { chart_version = var.elasticsearch_helm_version },
    "identityserver4admin"       = { chart_version = var.identityserver4admin_helm_version },
    "identityserver4admin_mssql" = { chart_version = var.identityserver4admin_mssql_helm_version },
    "seq"                        = { chart_version = var.seq_helm_version },
    "fluent"                     = { chart_version = var.fluent_helm_version },
    "vault"                      = { chart_version = var.vault_helm_version },
    "keycloak"                   = { chart_version = var.keycloak_helm_version },
    "whoami"                     = { chart_version = var.whoami_helm_version },
    "etcd"                       = { chart_version = var.etcd_helm_version },
    "minio"                      = { chart_version = var.minio_helm_version },
    "rabbitmq"                   = { chart_version = var.rabbitmq_helm_version },
    "kafka"                      = { chart_version = var.kafka_helm_version },
    "localstack"                 = { chart_version = var.localstack_helm_version },
    "mysql"                      = { chart_version = var.mysql_helm_version },
    "mariadb"                    = { chart_version = var.mariadb_helm_version },
    "postgres"                   = { chart_version = var.postgres_helm_version },
    "mssql"                      = { chart_version = var.mssql_helm_version },
    "mongodb"                    = { chart_version = var.mongodb_helm_version },
    "redis"                      = { chart_version = var.redis_helm_version },
    "docker_registry"            = { chart_version = var.docker_registry_helm_version },
    "vpa"                        = { chart_version = var.vpa_helm_version },
    "goldilocks"                 = { chart_version = var.goldilocks_helm_version },
    "dashboard"                 = { chart_version = var.dashboard_helm_version },
  }
}

module "versions" {
  source              = "./modules/utils/chartversions"
  config_file_content = file("./versions.yaml")
  input_versions      = local.chart_version_variables
}

module "metrics" {
  count        = var.install_metrics == true || var.install_vpa == true || var.install_goldilocks == true ? 1 : 0
  source       = "./modules/monitoring/metrics/metrics"
  helm_release = module.versions.chart_versions["metrics"].chart_version
}

module "certmanager" {
  count        = var.install_cert_manager == true ? 1 : 0
  source       = "./modules/networking/cert-manager"
  helm_release = module.versions.chart_versions["cert_manager"].chart_version
  namespace    = kubernetes_namespace.cert-manager[0].metadata[0].name
  depends_on = [
    kubernetes_namespace.cert-manager,
  ]
}

module "linkerd" {
  count               = var.install_linkerd == true ? 1 : 0
  source              = "./modules/networking/linkerd"
  helm_release        = module.versions.chart_versions["linkerd"].chart_version
  helm_release_crds   = module.versions.chart_versions["linkerdcrds"].chart_version
  helm_release_viz    = module.versions.chart_versions["linkerdviz"].chart_version
  helm_release_jaeger = module.versions.chart_versions["linkerdjaeger"].chart_version
  domain-name         = var.domain-name
  namespace           = kubernetes_namespace.linkerd[0].metadata[0].name
  tracing_enabled     = var.install_jaeger
  tracing_dataplane   = var.install_jaeger
  metrics_external    = var.install_prometheus
  depends_on = [
    module.certmanager,
    kubernetes_namespace.linkerd
  ]
}

module "traefik" {
  count                = var.install_traefik == true ? 1 : 0
  source               = "./modules/networking/traefik"
  helm_release         = module.versions.chart_versions["traefik"].chart_version
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
  helm_release       = module.versions.chart_versions["jaeger"].chart_version
  domain-name        = var.domain-name
  install_dashboards = var.install_prometheus
  namespace          = kubernetes_namespace.jaeger[0].metadata[0].name
  depends_on = [
    module.linkerd,
    kubernetes_namespace.jaeger
  ]
}

module "opentelemetry" {
  count              = var.install_opentelemetry == true ? 1 : 0
  source             = "./modules/monitoring/ingestion/opentelemetry"
  helm_release       = module.versions.chart_versions["opentelemetry"].chart_version
  expose_ingestion   = var.expose_opentelemetry
  namespace          = kubernetes_namespace.opentelemetry[0].metadata[0].name
  install_jaeger     = var.install_jaeger
  install_loki       = var.install_loki
  monitoring_backend = var.monitoring_backend
  depends_on = [
    module.linkerd,
    kubernetes_namespace.opentelemetry
  ]
}

module "loki" {
  count                 = var.install_loki == true ? 1 : 0
  source                = "./modules/monitoring/logging/loki"
  helm_release_loki     = module.versions.chart_versions["loki"].chart_version
  helm_release_promtail = module.versions.chart_versions["promtail"].chart_version
  install_promtail      = var.install_promtail
  tracing_enabled       = var.install_jaeger || var.install_tempo
  metrics_enabled       = var.install_prometheus
  expose_ingestion      = var.expose_loki
  namespace             = kubernetes_namespace.loki[0].metadata[0].name
  depends_on = [
    module.prometheus,
    kubernetes_namespace.loki
  ]
}

module "tempo" {
  count        = var.install_tempo == true ? 1 : 0
  source       = "./modules/monitoring/tracing/tempo"
  helm_release = module.versions.chart_versions["tempo"].chart_version
  namespace    = kubernetes_namespace.tempo[0].metadata[0].name
  depends_on = [
    module.linkerd,
    kubernetes_namespace.tempo
  ]
}

module "prometheus" {
  count              = var.install_prometheus == true || var.install_grafana == true ? 1 : 0
  source             = "./modules/monitoring/metrics/prometheus"
  helm_release       = module.versions.chart_versions["prometheus"].chart_version
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

module "argocd" {
  count              = var.install_argocd == true ? 1 : 0
  source             = "./modules/services/deployment/argocd"
  helm_release       = module.versions.chart_versions["argocd"].chart_version
  domain-name        = var.domain-name
  install_prometheus = var.install_prometheus
  namespace          = kubernetes_namespace.argocd[0].metadata[0].name
  depends_on = [
    module.jaeger,
    module.linkerd,
    kubernetes_namespace.argocd
  ]
}


module "elasticsearch" {
  count                 = var.install_elasticsearch == true ? 1 : 0
  source                = "./modules/services/search/elasticsearch"
  helm_release          = module.versions.chart_versions["elasticsearch"].chart_version
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
  helm_release = module.versions.chart_versions["vault"].chart_version
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
  helm_release       = module.versions.chart_versions["identityserver4admin"].chart_version
  mssql_helm_release = module.versions.chart_versions["identityserver4admin_mssql"].chart_version
  domain-name        = var.domain-name
  storageclass       = local.cluster_storageclass
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
  helm_release        = module.versions.chart_versions["seq"].chart_version
  fluent_helm_release = module.versions.chart_versions["fluent"].chart_version
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
  helm_release = module.versions.chart_versions["keycloak"].chart_version
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
  helm_release = module.versions.chart_versions["whoami"].chart_version
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
  helm_release = module.versions.chart_versions["minio"].chart_version
  domain-name  = var.domain-name
  metrics      = var.install_prometheus
  storageclass = local.cluster_storageclass
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
  helm_release = module.versions.chart_versions["etcd"].chart_version
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
  helm_release       = module.versions.chart_versions["rabbitmq"].chart_version
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
  helm_release = module.versions.chart_versions["localstack"].chart_version
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
  helm_release = module.versions.chart_versions["mysql"].chart_version
  expose_mysql = var.expose_mysql
  storageclass = local.cluster_storageclass
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
  helm_release    = module.versions.chart_versions["postgres"].chart_version
  expose_postgres = var.expose_postgres
  storageclass    = local.cluster_storageclass
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
  helm_release = module.versions.chart_versions["mssql"].chart_version
  expose_mssql = var.expose_mssql
  storageclass = local.cluster_storageclass
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
  helm_release   = module.versions.chart_versions["mariadb"].chart_version
  expose_mariadb = var.expose_mariadb
  storageclass   = local.cluster_storageclass
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
  helm_release   = module.versions.chart_versions["mongodb"].chart_version
  expose_mongodb = var.expose_mongodb
  storageclass   = local.cluster_storageclass
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
  count                   = var.install_oracle == true ? 1 : 0
  source                  = "./modules/services/database/rds/oracle-xe"
  domain-name             = var.domain-name
  expose_oracle           = var.expose_oracle
  oracle_operator_version = var.oracle_operator_version
  oracle_xe_version       = var.oracle_xe_version
  storageclass            = local.cluster_storageclass
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
  helm_release = module.versions.chart_versions["redis"].chart_version
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
  helm_release = module.versions.chart_versions["kafka"].chart_version
  expose_kafka = var.expose_kafka
  namespace    = kubernetes_namespace.kafka[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.kafka
  ]
}

module "registry" {
  count        = var.install_docker_registry == true ? 1 : 0
  source       = "./modules/services/storage/docker"
  domain-name  = var.domain-name
  helm_release = module.versions.chart_versions["docker_registry"].chart_version
  namespace    = kubernetes_namespace.docker_registry[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.docker_registry
  ]
}

module "vpa" {
  count        = var.install_vpa == true || var.install_goldilocks == true ? 1 : 0
  source       = "./modules/monitoring/vpa"
  domain-name  = var.domain-name
  helm_release = module.versions.chart_versions["vpa"].chart_version
  namespace    = kubernetes_namespace.vpa[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    module.metrics,
    kubernetes_namespace.vpa
  ]
}

module "goldilocks" {
  count        = var.install_goldilocks == true ? 1 : 0
  source       = "./modules/monitoring/goldilocks"
  domain-name  = var.domain-name
  helm_release = module.versions.chart_versions["goldilocks"].chart_version
  namespace    = kubernetes_namespace.goldilocks[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    module.vpa,
    kubernetes_namespace.goldilocks
  ]
}

module "dashboard" {
  count        = var.install_dashboard == true ? 1 : 0
  source       = "./modules/monitoring/dashboard"
  domain-name  = var.domain-name
  helm_release = module.versions.chart_versions["dashboard"].chart_version
  namespace    = kubernetes_namespace.dashboard[0].metadata[0].name
  depends_on = [
    module.coredns,
    module.linkerd,
    kubernetes_namespace.dashboard
  ]
}