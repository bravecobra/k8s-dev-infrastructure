cluster-context-name = "k3d-devinfra"
domain-name          = "k8s.local"
loadbalancer-ip           = "172.19.0.6"
node-ips = [
    "172.19.0.2",
    "172.19.0.3",
    "172.19.0.4"
]

//-------------------------------------
//Infrastructure
//-------------------------------------

//metrics
install_metrics      = false
metrics_helm_version = "6.0.0"

//cert-manager
install_cert_manager      = true
cert_manager_helm_version = "v1.8.0"

//linkerd
install_linkerd      = false
linkerd_helm_version = "2.11.2"

//traefik
install_traefik      = true
traefik_helm_version = "10.19.4"

//seq
install_seq = true
expose_seq  = false
seq_helm_version = "2022.1.7449"
fluent_helm_version = "0.19.23"

//jaeger
install_jaeger      = false
jaeger_helm_version = "2.29.0"

//opentelemetry
install_opentelemetry      = true
expose_opentelemetry        = true
opentelemetry_helm_version = "0.7.0"

//loki
install_loki          = false
loki_helm_version     = "2.11.1"
promtail_helm_version = "4.2.0"

//prometheus
install_prometheus      = false
prometheus_helm_version = "34.10.0"

//-------------------------------------
//Saas
//-------------------------------------

//argocd
install_argocd      = false
argocd_helm_version = "4.5.7"

//elasticsearch
install_elasticsearch      = false
install_kibana             = false
elasticsearch_helm_version = "2.1.0"

//vault
install_vault      = false
vault_helm_version = "0.19.0"

//identityserver4-admin
install_identityserver4admin      = false
identityserver4admin_helm_version = "0.5.2"
mssql_helm_version                = "0.1.0"

//keycloak
install_keycloak      = false
keycloak_helm_version = "18.1.0"
keycloak_include_domainrealm = true

//etcd
install_etcd      = false
etcd_helm_version = "8.0.1"

//minio
install_minio      = false
minio_helm_version = "3.6.6"

//Azurite
install_azurite    = false
expose_azurite     = false

//RabbitMQ
install_rabbitmq      = false
rabbitmq_helm_version = "2.6.1"

//-------------------------------------
//Examples
//-------------------------------------

//whoami
install_whoami      = false
whoami_helm_version = "2.5.5"