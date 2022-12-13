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

output "redis-password" {
  description = "Redis password"
  value       = join("", module.redis[*].redis-password)
  sensitive   = true
}

output "helm_version_cert-manager" {
  value = var.cert_manager_helm_version
}

output "helm_version_traefik" {
  value = var.traefik_helm_version
}

output "helm_version_linkerd" {
  value = var.linkerd_helm_version
}

output "helm_version_metrics" {
  value = var.metrics_helm_version
}

output "helm_version_seq" {
  value = var.seq_helm_version
}

output "helm_version_fluent" {
  value = var.fluent_helm_version
}

output "helm_version_jaeger" {
  value = var.jaeger_helm_version
}

output "helm_version_opentelemetry" {
  value = var.opentelemetry_helm_version
}

output "helm_version_loki" {
  value = var.loki_helm_version
}

output "helm_version_promtail" {
  value = var.promtail_helm_version
}

output "helm_version_tempo" {
  value = var.tempo_helm_version
}
output "helm_version_prometheus" {
  value = var.prometheus_helm_version
}

output "helm_version_argocd" {
  value = var.argocd_helm_version
}
output "helm_version_elasticsearch" {
  value = var.elasticsearch_helm_version
}

output "helm_version_vault" {
  value = var.vault_helm_version
}

output "helm_version_identityserveradmin" {
  value = var.identityserver4admin_helm_version
}
output "helm_version_identityserveradmin-mssql" {
  value = var.identityserver4admin_mssql_helm_version
}

output "helm_version_keycloak" {
  value = var.keycloak_helm_version
}

output "helm_version_etcd" {
  value = var.etcd_helm_version
}

output "helm_version_minio" {
  value = var.minio_helm_version
}

output "helm_version_rabbitmq" {
  value = var.rabbitmq_helm_version
}

output "helm_version_localstack" {
  value = var.localstack_helm_version
}

output "helm_version_mysql" {
  value = var.mysql_helm_version
}

output "helm_version_mariadb" {
  value = var.mariadb_helm_version
}

output "helm_version_postgres" {
  value = var.postgres_helm_version
}

output "helm_version_mssql" {
  value = var.mssql_helm_version
}

output "helm_version_redis" {
  value = var.redis_helm_version
}

output "helm_version_docker_registry" {
  value = var.docker_registry_helm_version
}