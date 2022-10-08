locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

# variable "github_owner" {
#   type        = string
#   description = "github owner"
# }

# variable "github_token" {
#   type        = string
#   description = "github token"
# }

variable "repository_create" {
  type    = bool
  default = false
}

variable "repository_name" {
  type        = string
  description = "github repository name"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "How visible is the github repo"
}

variable "branch" {
  type        = string
  default     = "master"
  description = "branch name"
}

variable "target_path" {
  type        = string
  description = "flux sync target path"
}

variable "domain-name" {
  type = string
}

variable "namespace" {
  description = "Namespace"
}