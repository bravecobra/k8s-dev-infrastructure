domain-name = "k8s.local"

# k3s
cluster-context-name = "k3d-devinfra"
loadbalancer-ip      = "172.19.0.7"
cluster-type         = "k3s"
node-ips = [
  "172.19.0.3",
  "172.19.0.4",
  "172.19.0.5"
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
# install_metrics = true

//vpa
# install_vpa        = true
# install_goldilocks = true

//cert-manager
# install_cert_manager = true

//linkerd
# install_linkerd = true

//traefik
# install_traefik = true

//-------------------------------------
// Monitoring
//-------------------------------------

# monitoring_backend = "grafana" #grafana, newrelic, datadog

# install_dashboard = true

//seq
# install_seq = true
# expose_seq  = true

//jaeger
# install_jaeger = true
# expose_jaeger  = true

//opentelemetry (operator)
# install_opentelemetry = true
# expose_opentelemetry  = true

//loki
# install_loki     = true
# expose_loki      = true
# install_promtail = true

//tempo
# install_tempo = true

//prometheus - grafana
# install_prometheus = true
# install_grafana    = true

# install_cadvisor = true

//-------------------------------------
// Search
//-------------------------------------

//elasticsearch
# install_elasticsearch = true
# install_kibana        = true

//-------------------------------------
// Caching
//-------------------------------------

//Redis
# install_redis = true
# expose_redis  = true

//-------------------------------------
// Config
//-------------------------------------

//vault
# install_vault = true

//etcd
# install_etcd = true

//-------------------------------------
// Security
//-------------------------------------

//identityserver4-admin
# install_identityserver4admin = true

//keycloak
# install_keycloak = true
# keycloak_include_domainrealm = true

//-------------------------------------
// Storage
//-------------------------------------

//minio
# install_minio = true

//Azurite
# install_azurite = true
# expose_azurite  = true

# install_docker_registry = true

//-------------------------------------
// Messaging
//-------------------------------------

//RabbitMQ
# install_rabbitmq = true
# expose_rabbitmq  = true

//Localstack
# install_localstack = true

//Kafka
# install_kafka = true
# expose_kafka  = true

//-------------------------------------
// Deployment
//-------------------------------------

//argocd
# install_argocd = true

//fluxcd
## Edit the .env file with a valid github username and token
# install_flux2                      = true
# flux2_namespace                    = "flux-system"
# flux2_github_repository_create     = true                 #use an existing (private) empty github repository
# flux2_github_repository_name       = "k8s-flux-example"   # name of the github repo
# flux2_github_repository_path       = "clusters/k8s-local" # path in the github repo where the flux config will be stored
# flux2_github_repository_visibility = "private"

//-------------------------------------
// Databases
//-------------------------------------

//MySQL
# install_mysql = true
# expose_mysql  = true

//Mariadb
# install_mariadb = true
# expose_mariadb  = true

//Postgres
# install_postgres = true
# expose_postgres  = true

//MSSQL
# install_mssql = true
# expose_mssql  = true

//MongoDb
# install_mongodb = true
# expose_mongodb  = true

//Oracle
# install_oracle = true
# expose_oracle  = true
# oracle_operator_version=0.2.1
# oracle_xe_version=21.3.0-xe

//-------------------------------------
//Examples
//-------------------------------------

//whoami
# install_whoami = true
