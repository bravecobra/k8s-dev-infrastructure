output "grafana-user" {
  description = "Grafana Admin user"
  value       = join("", module.prometheus[*].admin-user)
  sensitive   = true
}

output "grafana-password" {
  description = "Grafana Admin password"
  value       = join("", module.prometheus[*].admin-password)
  sensitive   = true
}

output "elastic-user" {
  description = "Elasticsearch password"
  value       = join("", module.elasticsearch[*].elastic-user)
  sensitive   = true
}

output "elastic-password" {
  description = "Elasticsearch user"
  value       = join("", module.elasticsearch[*].elastic-password)
  sensitive   = true
}

output "vault-password" {
  description = "Vault token"
  value       = join("", module.vault[*].vault-token)
  sensitive   = true
}

output "argocd-password" {
  description = "ArgoCD Initial Admin password"
  value       = join("", module.argocd[*].password)
  sensitive   = true
}

output "keycloak-password" {
  description = "Keycloak Initial Admin password"
  value       = join("", module.keycloak[*].keycloak-password)
  sensitive   = true
}