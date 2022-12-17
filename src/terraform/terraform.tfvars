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
# install_metrics = false

//cert-manager
# install_cert_manager = true

//linkerd
# install_linkerd = false

//traefik
# install_traefik = true

//-------------------------------------
// Monitoring
//-------------------------------------

//seq
# install_seq = false
# expose_seq  = false

//jaeger
# install_jaeger = false
# expose_jaeger  = false


//opentelemetry (operator)
# install_opentelemetry = false
# expose_opentelemetry  = false

//loki
# install_loki     = false
# expose_loki      = false
# install_promtail = false

//tempo
# install_tempo = false

//prometheus - grafana
# install_prometheus = false
# install_grafana    = false

//-------------------------------------
// Search
//-------------------------------------

//elasticsearch
# install_elasticsearch = false
# install_kibana        = false

//-------------------------------------
// Caching
//-------------------------------------

//Redis
# install_redis = false
# expose_redis  = false

//-------------------------------------
// Config
//-------------------------------------

//vault
# install_vault = false

//etcd
# install_etcd = false

//-------------------------------------
// Security
//-------------------------------------

//identityserver4-admin
# install_identityserver4admin = false

//keycloak
# install_keycloak = false
# keycloak_include_domainrealm = true

//-------------------------------------
// Storage
//-------------------------------------

//minio
# install_minio = false

//Azurite
# install_azurite = false
# expose_azurite  = false

# install_docker_registry = false

//-------------------------------------
// Messaging
//-------------------------------------

//RabbitMQ
# install_rabbitmq = false
# expose_rabbitmq  = false

//Localstack
# install_localstack = false

//Kafka
# install_kafka = false
# expose_kafka  = false

//-------------------------------------
// Deployment
//-------------------------------------

//argocd
# install_argocd = false

//fluxcd
## Edit the .env file with a valid github username and token
# install_flux2                      = false
# flux2_namespace                    = "flux-system"
# flux2_github_repository_create     = true                 #use an existing (private) empty github repository
# flux2_github_repository_name       = "k8s-flux-example"   # name of the github repo
# flux2_github_repository_path       = "clusters/k8s-local" # path in the github repo where the flux config will be stored
# flux2_github_repository_visibility = "private"

//-------------------------------------
// Databases
//-------------------------------------

//MySQL
# install_mysql = false
# expose_mysql  = false

//Mariadb
# install_mariadb = false
# expose_mariadb  = false

//Postgres
# install_postgres = false
# expose_postgres  = false

//MSSQL
# install_mssql = false
# expose_mssql  = false

//MongoDb
# install_mongodb = false
# expose_mongodb  = false

//Oracle
# install_oracle = false
# expose_oracle  = false

//-------------------------------------
//Examples
//-------------------------------------

//whoami
# install_whoami = false
