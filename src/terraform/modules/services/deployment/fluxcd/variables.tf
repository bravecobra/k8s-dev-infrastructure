variable "helm_release" {
  type = string
}

# variable "components_extra" {
#   type        = list(string)
#   default     =  []
#   description = "extra flux components"
# }

# variable "repository_name" {
#   type        = string
#   default     = "test-provider"
#   description = "github repository name"
# }

# variable "repository_visibility" {
#   type        = string
#   default     = "private"
#   description = "How visible is the github repo"
# }

# variable "branch" {
#   type        = string
#   default     = "main"
#   description = "branch name"
# }

# variable "target_path" {
#   type        = string
#   default     = "staging-cluster"
#   description = "flux sync target path"
# }

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

# variable "github_owner" {
#   type        = string
#   description = "github owner"
# }

# variable "github_token" {
#   type        = string
#   description = "github token"
# }