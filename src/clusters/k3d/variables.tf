variable "cluster-name" {
  type        = string
  default     = "devinfra"
  description = "Name of the cluster being created"
}

variable "server-node-count" {
  type        = number
  default     = 1
  description = "The amount of server nodes"
}

variable "worker-node-count" {
  type        = number
  default     = 0
  description = "The amount of worker nodes"
}

variable "install_private_registry" {
  type        = bool
  default     = true
  description = "Whether to start a private registry"
}

variable "k3s-version" {
  type        = string
  default     = "latest"
  description = "K3S version to use for the k3s containers"
}

variable "k3d-cluster-name" {
  default     = ["k3d"]
  type        = list(string)
  description = "K3DS cluster prefix"
}

variable "k3d-cluster-domain" {
  type        = string
  description = "The default domain name used in the cluster"
}

variable "k3d-cluster-port" {
  default     = 6445
  type        = number
  description = "The port for the k8s API server"
}

variable "k3d-cluster-ip" {
  default     = "0.0.0.0"
  type        = string
  description = "The Cluster IP"
}

variable "k3d-network-subnet" {
  default     = "172.19.0.0/16"
  type        = string
  description = "The subnet for the cluster"
}

variable "k3d-network-gateway" {
  default     = "172.19.0.1"
  type        = string
  description = "The network gateway for the cluster"
}

variable "expose_azurite" {
  type        = bool
  default     = false
  description = "Expose Azurite externally"
}

variable "expose_seq" {
  type        = bool
  default     = false
  description = "Expose Seq externally"
}

variable "expose_opentelemetry" {
  type        = bool
  default     = false
  description = "Expose OpenTelemetry Collector externally"
}

variable "expose_jaeger" {
  type        = bool
  default     = false
  description = "Expose Jaeger externally"
}

variable "expose_rabbitmq" {
  type        = bool
  default     = false
  description = "Expose rabbitmq externally"
}

variable "expose_loki" {
  type        = bool
  default     = false
  description = "Expose Loki externally"
}

variable "expose_rds_mssql" {
  type        = bool
  default     = false
  description = "Expose SQL Server externally"
}

variable "expose_rds_oracle" {
  type        = bool
  default     = false
  description = "Expose Oracle externally"
}

variable "expose_rds_mysql" {
  type        = bool
  default     = false
  description = "Expose Mysql externally"
}

variable "expose_rds_mariadb" {
  type        = bool
  default     = false
  description = "Expose MariaDb externally"
}

variable "expose_rds_postgres" {
  type        = bool
  default     = false
  description = "Expose Postgres externally"
}

variable "expose_nosql_mongodb" {
  type        = bool
  default     = false
  description = "Expose MongoDb externally"
}

variable "expose_redis" {
  type        = bool
  default     = false
  description = "Expose Redis externally"
}
