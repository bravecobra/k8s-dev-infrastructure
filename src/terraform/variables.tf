variable "cluster-context-name" {
  type = string
}

variable "domain-name" {
  type = string
}

variable "loadbalancer-ip" {
  type = string
  default = "172.19.0.2"
}

variable "node-ips" {
  type = list
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

//traefik
variable "install_traefik" {
  type    = bool
  default = true
}

variable "traefik_helm_version" {
  type = string
}

//linkerd
variable "install_linkerd" {
  type    = bool
  default = true
}
variable "linkerd_helm_version" {
  type = string
}

//prometheus
variable "prometheus_helm_version" {
  type = string
}
variable "install_prometheus" {
  type    = bool
  default = true
}

//jaeger
variable "jaeger_helm_version" {
  type = string
}
variable "install_jaeger" {
  type    = bool
  default = true
}

//loki
variable "install_loki" {
  type    = bool
  default = true
}
variable "loki_helm_version" {
  type = string
}
variable "promtail_helm_version" {
  type = string
}

//argocd
variable "install_argocd" {
  type    = bool
  default = true
}
variable "argocd_helm_version" {
  type = string
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

//seq
variable "install_seq" {
  type    = bool
  default = true
}

variable "seq_helm_version" {
  type = string
}

variable "fluent_helm_version" {
  type = string
}

//vault
variable "install_vault" {
  type    = bool
  default = true
}
variable "vault_helm_version" {
  type = string
}

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

variable "install_whoami" {
  type    = bool
  default = false
}

variable "whoami_helm_version" {
  type = string
}

variable "install_etcd" {
  type    = bool
  default = false
}

variable "etcd_helm_version" {
  type = string
}

variable "install_minio" {
  type    = bool
  default = false
}

variable "minio_helm_version" {
  type = string
}

variable "install_azurite" {
  type    = bool
  default = false
}

variable "install_rabbitmq" {
  type    = bool
  default = false
}

variable "rabbitmq_helm_version" {
  type = string
}