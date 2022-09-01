cluster-context-name = "k3d-devinfra"
domain-name          = "k8s.local"
loadbalancer-ip      = "172.19.0.6"
node-ips = [
  "172.19.0.2",
  "172.19.0.3",
  "172.19.0.4"
]

//-------------------------------------
// Networking
//-------------------------------------

//metrics
install_metrics      = false
metrics_helm_version = "6.0.10"

//cert-manager
install_cert_manager      = true
cert_manager_helm_version = "v1.9.1"

//linkerd
install_linkerd      = false
linkerd_helm_version = "2.11.4"

//traefik
install_traefik      = true
traefik_helm_version = "10.24.0"

//-------------------------------------
// Monitoring
//-------------------------------------

//seq
install_seq         = false
expose_seq          = false
seq_helm_version    = "2022.1.7929"
fluent_helm_version = "0.20.4"

//jaeger
install_jaeger      = false
expose_jaeger       = false
jaeger_helm_version = "2.23.0"

//opentelemetry (operator)
install_opentelemetry      = false
expose_opentelemetry       = false
opentelemetry_helm_version = "0.10.1"

//loki
install_loki          = false
expose_loki           = false
loki_helm_version     = "2.13.3"
promtail_helm_version = "6.2.2"

//tempo
install_tempo      = false
tempo_helm_version = "0.15.7"

//prometheus - grafana
install_prometheus      = false
install_grafana         = false
prometheus_helm_version = "39.4.0"

//-------------------------------------
//Saas
//-------------------------------------

//argocd
install_argocd      = false
argocd_helm_version = "4.10.5"

//elasticsearch
install_elasticsearch      = false
install_kibana             = false
elasticsearch_helm_version = "2.3.0"

//vault
install_vault      = false
vault_helm_version = "0.20.0"

//identityserver4-admin
install_identityserver4admin      = false
identityserver4admin_helm_version = "0.5.2"
identityserver4admin_mssql_helm_version = "0.1.0"

//keycloak
install_keycloak             = false
keycloak_helm_version        = "18.3.0"
keycloak_include_domainrealm = true

//etcd
install_etcd      = false
etcd_helm_version = "8.3.7"

//minio
install_minio      = false
minio_helm_version = "4.0.10"

//Azurite
install_azurite = false
expose_azurite  = false
azurite_version = "latest"

//RabbitMQ
install_rabbitmq      = false
expose_rabbitmq       = false
rabbitmq_helm_version = "2.6.11"

//Localstack
install_localstack = false
# expose_localstack       = false
localstack_helm_version = "0.4.1"

//fluxcd
## Edit the .env file with a valid github username and token
install_flux2                      = false
flux2_namespace                    = "flux-system"
flux2_github_repository_create     = true #use an existing (private) empty github repository
flux2_github_repository_name       = "k8s-flux-example" # name of the github repo
flux2_github_repository_path       = "clusters/k8s-local" # path in the github repo where the flux config will be stored
flux2_github_repository_visibility = "private"

//MySQL
install_mysql      = false
expose_mysql       = false
mysql_helm_version = "9.3.1"

//Postgres
install_postgres      = false
expose_postgres       = false
postgres_helm_version = "11.8.1"

//MSSQL
install_mssql      = false
expose_mssql       = false
mssql_helm_version = "1.0.2"
//-------------------------------------
//Examples
//-------------------------------------

//whoami
install_whoami      = false
whoami_helm_version = "2.5.5"
