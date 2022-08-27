locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

variable "cluster-context-name" {
  type = string
}

variable "domain-name" {
  type = string
}

variable "loadbalancer-ip" {
  type    = string
  default = "172.19.0.2"
}

variable "node-ips" {
  type = list(any)
  default = [
    "172.19.0.2"
  ]
}


//metrics
variable "install_metrics" {
  type    = bool
  default = false
}
variable "metrics_helm_version" {
  type = string
}

//cert-manager
variable "cert_manager_helm_version" {
  type = string
}
variable "install_cert_manager" {
  type    = bool
  default = false
}

variable "cert_manager_namespace" {
  type    = string
  default = "cert-manager"
}

//traefik
variable "install_traefik" {
  type    = bool
  default = true
}

variable "traefik_helm_version" {
  type = string
}

variable "traefik_namespace" {
  type    = string
  default = "traefik"
}

//linkerd
variable "install_linkerd" {
  type    = bool
  default = false
}
variable "linkerd_helm_version" {
  type = string
}

variable "linkerd_namespace" {
  type    = string
  default = "linkerd"
}

//prometheus
variable "prometheus_helm_version" {
  type = string
}
variable "install_prometheus" {
  type    = bool
  default = false
}

variable "prometheus_namespace" {
  type    = string
  default = "prometheus"
}

//grafana
variable "install_grafana" {
  type    = bool
  default = false
}

# variable "expose_prometheus" {
#   type    = bool
#   default = false
# }

//jaeger
variable "jaeger_helm_version" {
  type = string
}
variable "install_jaeger" {
  type    = bool
  default = false
}
variable "expose_jaeger" {
  type    = bool
  default = false
}

variable "jaeger_namespace" {
  type    = string
  default = "jaeger"
}

//opentelemetry
variable "opentelemetry_helm_version" {
  type = string
}
variable "install_opentelemetry" {
  type    = bool
  default = false
}
variable "expose_opentelemetry" {
  type    = bool
  default = false
}

variable "opentelemetry_namespace" {
  type    = string
  default = "opentelemetry"
}

//loki
variable "install_loki" {
  type    = bool
  default = false
}
variable "loki_helm_version" {
  type = string
}
variable "promtail_helm_version" {
  type = string
}
variable "expose_loki" {
  type    = bool
  default = false
}

variable "loki_namespace" {
  type    = string
  default = "loki"
}

//tempo
variable "install_tempo" {
  type    = bool
  default = true
}
variable "tempo_helm_version" {
  type = string
}

variable "tempo_namespace" {
  type    = string
  default = "tempo"
}

//argocd
variable "install_argocd" {
  type    = bool
  default = true
}
variable "argocd_helm_version" {
  type = string
}

variable "argocd_namespace" {
  type    = string
  default = "argocd"
}

//elasticsearch
variable "install_elasticsearch" {
  type    = bool
  default = true
}
variable "install_kibana" {
  type    = bool
  default = true
}
variable "elasticsearch_helm_version" {
  type = string
}

variable "elasticsearch_namespace" {
  type    = string
  default = "elasticsearch"
}

# variable "expose_elasticsearch" {
#   type = bool
# }

//identityserver4-admin
variable "install_identityserver4admin" {
  type    = bool
  default = true
}
variable "identityserver4admin_helm_version" {
  type = string
}

variable "mssql_helm_version" {
  type = string
}

variable "identityserver4admin_namespace" {
  type    = string
  default = "identityserver4"
}

//seq
variable "install_seq" {
  type    = bool
  default = true
}

variable "expose_seq" {
  type    = bool
  default = false
}

variable "seq_helm_version" {
  type = string
}

variable "fluent_helm_version" {
  type = string
}

variable "seq_namespace" {
  type    = string
  default = "seq"
}

//vault
variable "install_vault" {
  type    = bool
  default = true
}
variable "vault_helm_version" {
  type = string
}

variable "vault_namespace" {
  type    = string
  default = "vault"
}

# Keycloak
variable "install_keycloak" {
  type    = bool
  default = true
}

variable "keycloak_helm_version" {
  type = string
}

variable "keycloak_include_domainrealm" {
  type = bool
}

variable "keycloak_namespace" {
  type    = string
  default = "keycloak"
}

# WhoAmI
variable "install_whoami" {
  type    = bool
  default = false
}

variable "whoami_helm_version" {
  type = string
}

variable "whoami_namespace" {
  type    = string
  default = "whoami"
}

# Etcd
variable "install_etcd" {
  type    = bool
  default = false
}

variable "etcd_helm_version" {
  type = string
}

variable "etcd_namespace" {
  type    = string
  default = "etcd"
}

# minio
variable "install_minio" {
  type    = bool
  default = false
}

# variable "expose_minio" {
#   type    = bool
#   default = false
# }

variable "minio_helm_version" {
  type = string
}

variable "minio_namespace" {
  type    = string
  default = "minio"
}
# Azurite
variable "install_azurite" {
  type    = bool
  default = false
}

variable "expose_azurite" {
  type    = bool
  default = false
}

variable "azurite_version" {
  type = string
}

variable "azurite_namespace" {
  type    = string
  default = "azurite"
}

#rabbitmq
variable "install_rabbitmq" {
  type    = bool
  default = false
}

variable "expose_rabbitmq" {
  type    = bool
  default = false
}

variable "rabbitmq_namespace" {
  type    = string
  default = "rabbitmq"
}

variable "rabbitmq_helm_version" {
  type = string
}
# localstack
variable "install_localstack" {
  type    = bool
  default = false
}

variable "localstack_helm_version" {
  type = string
}

variable "localstack_namespace" {
  type    = string
  default = "localstack"
}

#flux2
variable "flux2_namespace" {
  type    = string
  default = "flux-system"
}

variable "install_flux2" {
  type    = bool
  default = false
}

variable "flux2_github_repository_create" {
  type    = bool
  default = false
}

variable "flux2_github_repository_name" {
  type = string
}

variable "flux2_github_repository_path" {
  type = string
}

variable "flux2_github_repository_visibility" {
  type    = string
  default = "private"
}

variable "flux2_github_repository_branch" {
  type    = string
  default = "master"
}