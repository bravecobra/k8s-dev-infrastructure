cluster-context-name = "k3d-devinfra"
domain-name          = "k8s.local"
loadbalancer-ip           = "172.19.0.6"
node-ips = [
    "172.19.0.2",
    "172.19.0.3",
    "172.19.0.4"
]

//metrics
install_metrics      = true
metrics_helm_version = "5.11.3"

//cert-manager
install_cert_manager      = true
cert_manager_helm_version = "v1.7.1"

//linkerd
install_linkerd      = true
linkerd_helm_version = "2.11.1"

//traefik
install_traefik      = true
traefik_helm_version = "10.15.0"

//jaeger
install_jaeger      = true
jaeger_helm_version = "2.29.0"

//loki
install_loki          = true
loki_helm_version     = "2.10.1"
promtail_helm_version = "3.11.0"

//prometheus
install_prometheus      = true
prometheus_helm_version = "33.2.1"

//argocd
install_argocd      = true
argocd_helm_version = "3.35.4"

//elasticsearch
install_elasticsearch      = true
install_kibana             = true
elasticsearch_helm_version = "2.1.0"

//vault
install_vault      = true
vault_helm_version = "0.19.0"

//identityserver4-admin
install_identityserver4admin      = true
identityserver4admin_helm_version = "0.5.2"
mssql_helm_version                = "0.1.0"

//seq
install_seq = true
seq_helm_version = "2022.1.7311-pre"
fluent_helm_version = "0.19.21"

//keycloak
install_keycloak      = true
keycloak_helm_version = "17.0.2"
forward_client_secret = "MS8UIocPolXerZAVfvOgDwg7YPvjHo22"

//whoami
install_whoami      = true
whoami_helm_version = "2.5.5"
