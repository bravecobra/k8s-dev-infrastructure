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

variable "cluster-type" {
  type    = string
  default = "k3s"
}


//metrics
variable "install_metrics" {
  type    = bool
  default = false
}
variable "metrics_helm_version" {
  type    = string
  default = "6.2.2"
}

//cert-manager
variable "cert_manager_helm_version" {
  type    = string
  default = ""
}
variable "install_cert_manager" {
  type    = bool
  default = true
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
  type    = string
  default = ""
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
  type    = string
  default = "2.11.5"
}

variable "linkerd_namespace" {
  type    = string
  default = "linkerd"
}

//prometheus
variable "prometheus_helm_version" {
  type    = string
  default = "41.7.1"
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
  type    = string
  default = "2.36.0"
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
  type    = string
  default = "0.17.0"
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
  type    = string
  default = "3.3.1"
}
variable "install_promtail" {
  type    = bool
  default = false
}
variable "promtail_helm_version" {
  type    = string
  default = "6.6.0"
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
  default = false
}
variable "tempo_helm_version" {
  type    = string
  default = "0.16.3"
}

variable "tempo_namespace" {
  type    = string
  default = "tempo"
}

//argocd
variable "install_argocd" {
  type    = bool
  default = false
}
variable "argocd_helm_version" {
  type    = string
  default = "5.12.2"
}

variable "argocd_namespace" {
  type    = string
  default = "argocd"
}

//elasticsearch
variable "install_elasticsearch" {
  type    = bool
  default = false
}
variable "install_kibana" {
  type    = bool
  default = false
}
variable "elasticsearch_helm_version" {
  type    = string
  default = "2.4.0"
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
  default = false
}
variable "identityserver4admin_helm_version" {
  type    = string
  default = "0.5.2"
}

variable "identityserver4admin_mssql_helm_version" {
  type    = string
  default = "0.1.0"
}

variable "identityserver4admin_namespace" {
  type    = string
  default = "identityserver4"
}

//seq
variable "install_seq" {
  type    = bool
  default = false
}

variable "expose_seq" {
  type    = bool
  default = false
}

variable "seq_helm_version" {
  type    = string
  default = "2022.1.7929"
}

variable "fluent_helm_version" {
  type    = string
  default = "0.20.9"
}

variable "seq_namespace" {
  type    = string
  default = "seq"
}

//vault
variable "install_vault" {
  type    = bool
  default = false
}
variable "vault_helm_version" {
  type    = string
  default = "0.22.1"
}

variable "vault_namespace" {
  type    = string
  default = "vault"
}

# Keycloak
variable "install_keycloak" {
  type    = bool
  default = false
}

variable "keycloak_helm_version" {
  type    = string
  default = "18.3.0"
}

variable "keycloak_include_domainrealm" {
  type    = bool
  default = false
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
  type    = string
  default = "2.5.5"
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
  type    = string
  default = "8.5.8"
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
  type    = string
  default = "5.0.0"
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
  type    = string
  default = "latest"
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
  type    = string
  default = "3.1.1"
}


# kafka
variable "install_kafka" {
  type    = bool
  default = false
}

variable "expose_kafka" {
  type    = bool
  default = false
}

variable "kafka_namespace" {
  type    = string
  default = "kafka"
}

variable "kafka_helm_version" {
  type    = string
  default = "0.32.0"
}

# localstack
variable "install_localstack" {
  type    = bool
  default = false
}

variable "localstack_helm_version" {
  type    = string
  default = "0.5.0"
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
  default = true
}

variable "flux2_github_repository_name" {
  type    = string
  default = "k8s-flux-example"
}

variable "flux2_github_repository_path" {
  type    = string
  default = "clusters/k8s-local"
}

variable "flux2_github_repository_visibility" {
  type    = string
  default = "private"
}

variable "flux2_github_repository_branch" {
  type    = string
  default = "master"
}

# MySQL
variable "install_mysql" {
  type    = bool
  default = false
}

variable "expose_mysql" {
  type    = bool
  default = false
}

variable "mysql_namespace" {
  type    = string
  default = "mysql"
}

variable "mysql_helm_version" {
  type    = string
  default = "9.4.1"
}

# Mariadb
variable "install_mariadb" {
  type    = bool
  default = false
}

variable "expose_mariadb" {
  type    = bool
  default = false
}

variable "mariadb_namespace" {
  type    = string
  default = "mariadb"
}

variable "mariadb_helm_version" {
  type    = string
  default = "11.3.3"
}

# Postgres
variable "install_postgres" {
  type    = bool
  default = false
}

variable "expose_postgres" {
  type    = bool
  default = false
}

variable "postgres_namespace" {
  type    = string
  default = "postgres"
}

variable "postgres_helm_version" {
  type    = string
  default = "12.0.0"
}

# mssql
variable "install_mssql" {
  type    = bool
  default = false
}

variable "expose_mssql" {
  type    = bool
  default = false
}

variable "mssql_namespace" {
  type    = string
  default = "mssql"
}

variable "mssql_helm_version" {
  type    = string
  default = "1.2.0"
}

# mongodb
variable "install_mongodb" {
  type    = bool
  default = false
}

variable "expose_mongodb" {
  type    = bool
  default = false
}

variable "mongodb_namespace" {
  type    = string
  default = "mongodb"
}

variable "mongodb_helm_version" {
  type    = string
  default = "13.1.5"
}

# oracle
variable "install_oracle" {
  type    = bool
  default = false
}

variable "expose_oracle" {
  type    = bool
  default = false
}

variable "oracle_namespace" {
  type    = string
  default = "oracle"
}

variable "oracle_operator_version" {
  type    = string
  default = "0.2.0"
}
variable "oracle_xe_version" {
  type    = string
  default = "21.3.0-xe"
}

# redis
variable "install_redis" {
  type    = bool
  default = false
}

variable "redis_helm_version" {
  type    = string
  default = "17.3.11"
}

variable "redis_namespace" {
  type    = string
  default = "redis"
}

variable "expose_redis" {
  type    = bool
  default = false
}

variable "install_docker_registry" {
  type    = bool
  default = false
}

variable "docker_registry_helm_version" {
  type    = string
  default = "0.4.3"
}

variable "docker_registry_namespace" {
  type    = string
  default = "registryui"
}