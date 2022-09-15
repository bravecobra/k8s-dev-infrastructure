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

variable "helm_release" {
  type    = string
  default = "10.3.6"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "install_dashboards" {
  type = bool
}

variable "namespace" {
  description = "Namespace"
  default     = "traefik"
}

variable "use_metrics" {
  type    = bool
  default = false
}

variable "use_tracing" {
  type    = bool
  default = false
}

variable "expose_azurite" {
  type    = bool
  default = false
}

variable "expose_seq" {
  type    = bool
  default = false
}

variable "expose_opentelemetry" {
  type    = bool
  default = false
}

variable "expose_loki" {
  type    = bool
  default = false
}

variable "expose_jaeger" {
  type    = bool
  default = false
}

# variable "expose_minio" {
#   type = bool
#   default = false
# }

# variable "expose_prometheus" {
#   type = bool
#   default = false
# }

# variable "expose_elasticsearch" {
#   type = bool
#   default = false
# }

variable "expose_rabbitmq" {
  type    = bool
  default = false
}

variable "expose_mysql" {
  type    = bool
  default = false
}

variable "expose_postgres" {
  type    = bool
  default = false
}

variable "expose_mssql" {
  type    = bool
  default = false
}

variable "expose_mariadb" {
  type    = bool
  default = false
}

variable "expose_mongodb" {
  type    = bool
  default = false
}

variable "expose_oracle" {
  type    = bool
  default = false
}

variable "expose_redis" {
  type    = bool
  default = false
}

variable "expose_kafka" {
  type = bool
  default = false
}

variable "cluster-type" {
  type = string
}