locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

variable "cluster-context-name" {
  type        = string
  description = "The kubectl context to use"
}

variable "domain-name" {
  type        = string
  description = "The toplevel domain of the cluster"
}

variable "loadbalancer-ip" {
  type        = string
  default     = "172.19.0.2"
  description = "The IP of the loadbalancer"
}

variable "node-ips" {
  type = list(any)
  default = [
    "172.19.0.2"
  ]
  description = "The list of ip's of nodes in the cluster"
}

variable "cluster-type" {
  type        = string
  default     = "k3s"
  description = "The type of the cluster. Important for Traefik to route traffic correctly"
}

//metrics
variable "install_metrics" {
  type        = bool
  default     = false
  description = "Flag to install metrics server"
}

variable "metrics_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of metrics-server"
}

// VPA
variable "install_vpa" {
  type        = bool
  default     = false
  description = "Flag to install vpa"
}
variable "vpa_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of vpa"
}

variable "vpa_namespace" {
  type        = string
  default     = "vpa"
  description = "Namespace of vpa"
}

// goldilocks
variable "install_goldilocks" {
  type        = bool
  default     = false
  description = "Flag to install goldilocks"
}
variable "goldilocks_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of goldilocks"
}

variable "goldilocks_namespace" {
  type        = string
  default     = "goldilocks"
  description = "Namespace of goldilocks"
}

//cert-manager
variable "cert_manager_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of cert-manager"
}
variable "install_cert_manager" {
  type        = bool
  default     = true
  description = "Flag to install cert-manager"
}

variable "cert_manager_namespace" {
  type        = string
  default     = "cert-manager"
  description = "Namespace of cert-manager"
}

//traefik
variable "install_traefik" {
  type        = bool
  default     = true
  description = "Flag to install traefik"
}

variable "traefik_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of traefik"
}

variable "traefik_namespace" {
  type        = string
  default     = "traefik"
  description = "Namespace of traefik"
}

//linkerd
variable "install_linkerd" {
  type        = bool
  default     = false
  description = "Flag to install linkerd"
}
variable "linkerd_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of linkerd"
}

variable "linkerdcrds_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of linkerd-crds"
}

variable "linkerdviz_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of linkerd-viz"
}

variable "linkerdjaeger_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of linkerd-jaeger"
}

variable "linkerd_namespace" {
  type        = string
  default     = "linkerd"
  description = "Namespace of linkerd"
}

//dashboard
variable "dashboard_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of dashboard"
}

variable "install_dashboard" {
  type        = bool
  default     = false
  description = "Flag to install kubernetes dashboard"
}

variable "dashboard_namespace" {
  type        = string
  default     = "dashboard"
  description = "Namespace of dashboard"
}

//prometheus
variable "prometheus_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of prometheus"
}
variable "install_prometheus" {
  type        = bool
  default     = false
  description = "Flag to install prometheus"
}

variable "prometheus_namespace" {
  type        = string
  default     = "prometheus"
  description = "Namespace of prometheus"
}

//grafana
variable "install_grafana" {
  type        = bool
  default     = false
  description = "Flag to install grafana"
}

//jaeger
variable "jaeger_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of jaeger"
}
variable "install_jaeger" {
  type        = bool
  default     = false
  description = "Flag to install jaeger"
}
variable "expose_jaeger" {
  type        = bool
  default     = false
  description = "Flag to expose jaeger externally"
}

variable "jaeger_namespace" {
  type        = string
  default     = "jaeger"
  description = "Namespace of Jaeger"
}

//opentelemetry
variable "opentelemetry_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of opentelemetry collector"
}
variable "install_opentelemetry" {
  type        = bool
  default     = false
  description = "Flag to install opentelemetry collector"
}
variable "expose_opentelemetry" {
  type        = bool
  default     = false
  description = "Flag to expose opentelemetry collector externally"
}

variable "monitoring_backend" {
  type        = string
  default     = "grafana"
  description = "Default monitoring backend"
}

variable "opentelemetry_namespace" {
  type        = string
  default     = "opentelemetry"
  description = "Namespace of opentelemetry collector"
}

//loki
variable "install_loki" {
  type        = bool
  default     = false
  description = "Flag to install Loki"
}
variable "loki_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of loki"
}
variable "install_promtail" {
  type        = bool
  default     = false
  description = "Flag to install promtail"
}
variable "promtail_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of promtail"
}
variable "expose_loki" {
  type        = bool
  default     = false
  description = "Flag to expose loki externally"
}

variable "loki_namespace" {
  type        = string
  default     = "loki"
  description = "Namespace of loki"
}

//tempo
variable "install_tempo" {
  type        = bool
  default     = false
  description = "Flag to install tempo"
}
variable "tempo_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of tempo"
}

variable "tempo_namespace" {
  type        = string
  default     = "tempo"
  description = "Namespace of tempo"
}

//argocd
variable "install_argocd" {
  type        = bool
  default     = false
  description = "Flag to install argocd"
}
variable "argocd_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of argocd"
}

variable "argocd_namespace" {
  type        = string
  default     = "argocd"
  description = "Namespace of argocd"
}

//elasticsearch
variable "install_elasticsearch" {
  type        = bool
  default     = false
  description = "Flag to install elasticsearch"
}
variable "install_kibana" {
  type        = bool
  default     = false
  description = "Flag to install kibana"
}
variable "elasticsearch_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of ECK (Elasticsearch Operator)"
}

variable "elasticsearch_namespace" {
  type        = string
  default     = "elasticsearch"
  description = "Namespace of elasticsearch"
}

//identityserver4-admin
variable "install_identityserver4admin" {
  type        = bool
  default     = false
  description = "Flag to install identityserver4-admin"
}
variable "identityserver4admin_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of Identityserver4 Admin"
}

variable "identityserver4admin_mssql_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of SQL Server for Identityserver4 Admin"
}

variable "identityserver4admin_namespace" {
  type        = string
  default     = "identityserver4"
  description = "Namespace of Identityserver4 Admin"
}

//seq
variable "install_seq" {
  type        = bool
  default     = false
  description = "Flag to install seq"
}

variable "expose_seq" {
  type        = bool
  default     = false
  description = "Flag to expose seq externally"
}

variable "seq_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of seq"
}

variable "fluent_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of fluent-bit"
}

variable "seq_namespace" {
  type        = string
  default     = "seq"
  description = "Namespace of seq"
}

//vault
variable "install_vault" {
  type        = bool
  default     = false
  description = "Flag to install vault"
}
variable "vault_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of vault"
}

variable "vault_namespace" {
  type        = string
  default     = "vault"
  description = "Namespace of vault"
}

# Keycloak
variable "install_keycloak" {
  type        = bool
  default     = false
  description = "Flag to install keycloak"
}

variable "keycloak_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of keycloak"
}

variable "keycloak_include_domainrealm" {
  type        = bool
  default     = false
  description = "Flag to include a default realm"
}

variable "keycloak_namespace" {
  type        = string
  default     = "keycloak"
  description = "Namespace of keycloak"
}

# WhoAmI
variable "install_whoami" {
  type        = bool
  default     = false
  description = "Flag to install whoami"
}

variable "whoami_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of whoami"
}

variable "whoami_namespace" {
  type        = string
  default     = "whoami"
  description = "Namespace of whoami"
}

# Etcd
variable "install_etcd" {
  type        = bool
  default     = false
  description = "Flag to install etcd"
}

variable "etcd_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of etcd"
}

variable "etcd_namespace" {
  type        = string
  default     = "etcd"
  description = "Namespace of etcd"
}

# minio
variable "install_minio" {
  type        = bool
  default     = false
  description = "Flag to install minio"
}

variable "minio_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of minio"
}

variable "minio_namespace" {
  type        = string
  default     = "minio"
  description = "Namespace of minio"
}
# Azurite
variable "install_azurite" {
  type        = bool
  default     = false
  description = "Flag to install azurite"
}

variable "expose_azurite" {
  type        = bool
  default     = false
  description = "Flag to expose azurite externally"
}

variable "azurite_version" {
  type        = string
  default     = "latest"
  description = "Override version of azurite"
}

variable "azurite_namespace" {
  type        = string
  default     = "azurite"
  description = "Namespace of azurite"
}

#rabbitmq
variable "install_rabbitmq" {
  type        = bool
  default     = false
  description = "Flag to install rabbitmq"
}

variable "expose_rabbitmq" {
  type        = bool
  default     = false
  description = "Flag to expose rabbitmq externally"
}

variable "rabbitmq_namespace" {
  type        = string
  default     = "rabbitmq"
  description = "Namespace of rabbitmq"
}

variable "rabbitmq_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of rabbitmq"
}


# kafka
variable "install_kafka" {
  type        = bool
  default     = false
  description = "Flag to install kafka"
}

variable "expose_kafka" {
  type        = bool
  default     = false
  description = "Flag to expose kafka externally"
}

variable "kafka_namespace" {
  type        = string
  default     = "kafka"
  description = "Namespace of kafka"
}

variable "kafka_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of kafka strimzi"
}

# localstack
variable "install_localstack" {
  type        = bool
  default     = false
  description = "Flag to install localstack"
}

variable "localstack_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of localstack"
}

variable "localstack_namespace" {
  type        = string
  default     = "localstack"
  description = "Namespace of localstack"
}

#flux2
variable "flux2_namespace" {
  type        = string
  default     = "flux-system"
  description = "Namespace of Flux2"
}

variable "install_flux2" {
  type        = bool
  default     = false
  description = "Flag to install flux2"
}

variable "flux2_github_repository_create" {
  type        = bool
  default     = true
  description = "Create github repo to read configuration from"
}

variable "flux2_github_repository_name" {
  type        = string
  default     = "k8s-flux-example"
  description = "Name of the github repo to create"
}

variable "flux2_github_repository_path" {
  type        = string
  default     = "clusters/k8s-local"
  description = "The path inside the repo to read configuration"
}

variable "flux2_github_repository_visibility" {
  type        = string
  default     = "private"
  description = "Visibility of the repository"
}

variable "flux2_github_repository_branch" {
  type        = string
  default     = "master"
  description = "The branch to read configuration from"
}

# MySQL
variable "install_mysql" {
  type        = bool
  default     = false
  description = "Flag to install mysql"
}

variable "expose_mysql" {
  type        = bool
  default     = false
  description = "Flag to expose mysql externally"
}

variable "mysql_namespace" {
  type        = string
  default     = "mysql"
  description = "Namespace of mysql"
}

variable "mysql_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of mysql"
}

# Mariadb
variable "install_mariadb" {
  type        = bool
  default     = false
  description = "Flag to install mariadb"
}

variable "expose_mariadb" {
  type        = bool
  default     = false
  description = "Flag to expose mariadb externally"
}

variable "mariadb_namespace" {
  type        = string
  default     = "mariadb"
  description = "Namespace of mariadb"
}

variable "mariadb_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of mariadb"
}

# Postgres
variable "install_postgres" {
  type        = bool
  default     = false
  description = "Flag to install postgres"
}

variable "expose_postgres" {
  type        = bool
  default     = false
  description = "Flag to expose postgres externally"
}

variable "postgres_namespace" {
  type        = string
  default     = "postgres"
  description = "Namespace of postgres"
}

variable "postgres_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of postgres"
}

# mssql
variable "install_mssql" {
  type        = bool
  default     = false
  description = "Flag to install SQL Server"
}

variable "expose_mssql" {
  type        = bool
  default     = false
  description = "Flag to expose SQL Server externally"
}

variable "mssql_namespace" {
  type        = string
  default     = "mssql"
  description = "Namespace of SQL Server"
}

variable "mssql_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of SQL Server"
}

# mongodb
variable "install_mongodb" {
  type        = bool
  default     = false
  description = "Flag to install MongoDB"
}

variable "expose_mongodb" {
  type        = bool
  default     = false
  description = "Flag to expose mongodb externally"
}

variable "mongodb_namespace" {
  type        = string
  default     = "mongodb"
  description = "Namespace of mongodb"
}

variable "mongodb_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of mongodb"
}

# oracle
variable "install_oracle" {
  type        = bool
  default     = false
  description = "Flag to install Oracle XE"
}

variable "expose_oracle" {
  type        = bool
  default     = false
  description = "Flag to expose Oracl XE externally"
}

variable "oracle_namespace" {
  type        = string
  default     = "oracle"
  description = "Namespace of Oracle XE"
}

variable "oracle_operator_version" {
  type        = string
  default     = "0.2.1"
  description = "Version of the Oracle Operator to use"
}
variable "oracle_xe_version" {
  type        = string
  default     = "21.3.0-xe"
  description = "Version of the Oracle XE server to install"
}

# redis
variable "install_redis" {
  type        = bool
  default     = false
  description = "Flag to install redis"
}

variable "redis_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of redis"
}

variable "redis_namespace" {
  type        = string
  default     = "redis"
  description = "Namespace of redis"
}

variable "expose_redis" {
  type        = bool
  default     = false
  description = "Flag to expose redis externally"
}

variable "install_docker_registry" {
  type        = bool
  default     = false
  description = "Flag to install docker-registry"
}

variable "docker_registry_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of docker-registry"
}

variable "docker_registry_namespace" {
  type        = string
  default     = "registryui"
  description = "Namespace of docker-registry"
}

variable "cadvisor_namespace" {
  type        = string
  default     = "cadvisor"
  description = "Namespace of cadvisor"
}

variable "install_cadvisor" {
  type        = bool
  default     = false
  description = "Flag to install cadvisor"
}

variable "cadvisor_helm_version" {
  type        = string
  default     = ""
  description = "Override Helm version of cadvisor"
}