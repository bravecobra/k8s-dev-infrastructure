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

output "minio-password" {
  description = "Minio Initial root password"
  value       = join("", module.minio[*].minio-password)
  sensitive   = true
}

output "etcd-password" {
  description = "Etcd Initial Admin password"
  value       = join("", module.etcd[*].etcd-password)
  sensitive   = true
}

output "mysql-password" {
  description = "Mysql password"
  value       = join("", module.mysql[*].mysql-root-password)
  sensitive   = true
}

output "postgres-password" {
  description = "Postgres password"
  value       = join("", module.postgres[*].postgres-root-password)
  sensitive   = true
}

output "mssql-password" {
  description = "MSSQL password"
  value       = join("", module.mssql[*].mssql-root-password)
  sensitive   = true
}

output "mariadb-password" {
  description = "MariaDB password"
  value       = join("", module.mariadb[*].mariadb-root-password)
  sensitive   = true
}

output "mongodb-password" {
  description = "MongoDB password"
  value       = join("", module.mongodb[*].mongodb-root-password)
  sensitive   = true
}

output "oracle-password" {
  description = "Oracle password"
  value       = join("", module.oraclexe[*].oracle-password)
  sensitive   = true
}