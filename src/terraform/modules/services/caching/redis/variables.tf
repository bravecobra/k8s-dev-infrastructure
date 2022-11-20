variable "helm_release" {
  type = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_redis" {
  type        = bool
  description = "Expose Redis"
}

variable "replica_count" {
  description = "Replicas count"
  default     = 0
}