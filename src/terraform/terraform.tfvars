cluster-context-name = "kind-devinfra"
domain-name          = "k8s.local"
ingress-ip           = "172.18.0.2"

//metrics
metrics_helm_version = "5.10.4"

//cert-manager
install_cert_manager      = true
cert_manager_helm_version = "v1.5.4"

//linkerd
install_linkerd      = true
linkerd_helm_version = "2.11.0"

//traefik
install_traefik      = true
traefik_helm_version = "10.3.6"

//jaeger
install_jaeger      = true
jaeger_helm_version = "2.25.0"

//loki
install_loki          = true
loki_helm_version     = "2.6.0"
promtail_helm_version = "3.8.1"

//prometheus
install_prometheus      = true
prometheus_helm_version = "19.0.2"

//argocd
install_argocd      = false
argocd_helm_version = "3.24.0"

//elasticsearch
install_elasticsearch      = false
install_kibana             = false
elasticsearch_helm_version = "1.8.0"

//vault
install_vault      = false
vault_helm_version = "0.16.1"

//identityserver4-admin
install_identityserver4admin      = false
identityserver4admin_helm_version = "0.5.2"
mssql_helm_version                = "0.1.0"