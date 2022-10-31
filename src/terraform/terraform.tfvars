domain-name = "k8s.local"

# k3s
cluster-context-name = "k3d-devinfra"
loadbalancer-ip      = "172.19.0.6"
cluster-type         = "k3s"
node-ips = [
  "172.19.0.2",
  "172.19.0.3",
  "172.19.0.4"
]

# kind
# cluster-context-name = "kind-devinfra"
# cluster-type = "kind"
# loadbalancer-ip      = "172.19.0.2"
# node-ips = [
#   "172.19.0.2",
#   "172.19.0.3",
#   "172.19.0.4"
# ]


# Rancher desktop
# cluster-context-name = "rancher-desktop"
# loadbalancer-ip      = "172.25.179.43"
# node-ips = [
#   "172.25.179.43"
# ]

//-------------------------------------
// Networking
//-------------------------------------

//metrics
install_metrics      = false
metrics_helm_version = "6.2.0"

//cert-manager
install_cert_manager      = true
cert_manager_helm_version = "v1.9.1"

//linkerd
install_linkerd      = false
linkerd_helm_version = "2.11.5"

//traefik
install_traefik      = true
traefik_helm_version = "10.26.1"

//-------------------------------------
// Monitoring
//-------------------------------------

//seq
install_seq         = false
expose_seq          = false
seq_helm_version    = "2022.1.7929"
fluent_helm_version = "0.20.8"

//jaeger
install_jaeger      = false
expose_jaeger       = false
jaeger_helm_version = "2.23.0"

//opentelemetry (operator)
install_opentelemetry      = false
expose_opentelemetry       = false
opentelemetry_helm_version = "0.16.0"

//loki
install_loki          = false
expose_loki           = false
install_promtail      = false
loki_helm_version     = "3.2.1"
promtail_helm_version = "6.5.1"

//tempo
install_tempo      = false
tempo_helm_version = "0.16.2"

//prometheus - grafana
install_prometheus      = false
install_grafana         = false
prometheus_helm_version = "41.5.1"

//-------------------------------------
//Saas
//-------------------------------------

//argocd
install_argocd      = false
argocd_helm_version = "5.5.6"

//elasticsearch
install_elasticsearch      = false
install_kibana             = false
elasticsearch_helm_version = "2.4.0"

//vault
install_vault      = false
vault_helm_version = "0.22.0"

//identityserver4-admin
install_identityserver4admin            = false
identityserver4admin_helm_version       = "0.5.2"
identityserver4admin_mssql_helm_version = "0.1.0"

//keycloak
install_keycloak             = false
keycloak_helm_version        = "18.3.0"
keycloak_include_domainrealm = true

//etcd
install_etcd      = false
etcd_helm_version = "8.5.5"

//minio
install_minio      = false
minio_helm_version = "4.0.15"

//Azurite
install_azurite = false
expose_azurite  = false
azurite_version = "latest"

//RabbitMQ
install_rabbitmq      = false
expose_rabbitmq       = false
rabbitmq_helm_version = "3.0.0"

//Localstack
install_localstack = false
# expose_localstack       = false
localstack_helm_version = "0.4.2"

//fluxcd
## Edit the .env file with a valid github username and token
install_flux2                      = false
flux2_namespace                    = "flux-system"
flux2_github_repository_create     = true                 #use an existing (private) empty github repository
flux2_github_repository_name       = "k8s-flux-example"   # name of the github repo
flux2_github_repository_path       = "clusters/k8s-local" # path in the github repo where the flux config will be stored
flux2_github_repository_visibility = "private"

//MySQL
install_mysql      = false
expose_mysql       = false
mysql_helm_version = "9.3.4"

//Mariadb
install_mariadb      = false
expose_mariadb       = false
mariadb_helm_version = "11.3.1"

//Postgres
install_postgres      = false
expose_postgres       = false
postgres_helm_version = "11.9.2"

//MSSQL
install_mssql      = false
expose_mssql       = false
mssql_helm_version = "1.1.0"

//MongoDb
install_mongodb      = false
expose_mongodb       = false
mongodb_helm_version = "13.1.5"

//Oracle
install_oracle          = false
expose_oracle           = false
oracle_operator_version = "0.2.0"
oracle_xe_version       = "21.3.0-xe"

//-------------------------------------
//Examples
//-------------------------------------

//whoami
install_whoami      = false
whoami_helm_version = "2.5.5"
