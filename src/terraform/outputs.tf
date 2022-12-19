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
  value = module.versions.chart_versions["cert_manager"].chart_version
}

output "helm_version_traefik" {
  value = module.versions.chart_versions["traefik"].chart_version
}

output "helm_version_linkerd" {
  value = module.versions.chart_versions["linkerd"].chart_version
}

output "helm_version_metrics" {
  value = module.versions.chart_versions["metrics"].chart_version
}

output "helm_version_seq" {
  value = module.versions.chart_versions["seq"].chart_version
}

output "helm_version_fluent" {
  value = module.versions.chart_versions["fluent"].chart_version
}

output "helm_version_jaeger" {
  value = module.versions.chart_versions["jaeger"].chart_version
}

output "helm_version_opentelemetry" {
  value = module.versions.chart_versions["opentelemetry"].chart_version
}

output "helm_version_loki" {
  value = module.versions.chart_versions["loki"].chart_version
}

output "helm_version_promtail" {
  value = module.versions.chart_versions["promtail"].chart_version
}

output "helm_version_tempo" {
  value = module.versions.chart_versions["tempo"].chart_version
}
output "helm_version_prometheus" {
  value = module.versions.chart_versions["prometheus"].chart_version
}

output "helm_version_argocd" {
  value = module.versions.chart_versions["argocd"].chart_version
}
output "helm_version_elasticsearch" {
  value = module.versions.chart_versions["elasticsearch"].chart_version
}

output "helm_version_vault" {
  value = module.versions.chart_versions["vault"].chart_version
}

output "helm_version_identityserveradmin" {
  value = module.versions.chart_versions["identityserver4admin"].chart_version
}
output "helm_version_identityserveradmin-mssql" {
  value = module.versions.chart_versions["identityserver4admin_mssql"].chart_version
}

output "helm_version_keycloak" {
  value = module.versions.chart_versions["keycloak"].chart_version
}

output "helm_version_etcd" {
  value = module.versions.chart_versions["etcd"].chart_version
}

output "helm_version_minio" {
  value = module.versions.chart_versions["minio"].chart_version
}

output "helm_version_rabbitmq" {
  value = module.versions.chart_versions["rabbitmq"].chart_version
}

output "helm_version_localstack" {
  value = module.versions.chart_versions["localstack"].chart_version
}

output "helm_version_mysql" {
  value = module.versions.chart_versions["mysql"].chart_version
}

output "helm_version_mariadb" {
  value = module.versions.chart_versions["mariadb"].chart_version
}

output "helm_version_postgres" {
  value = module.versions.chart_versions["postgres"].chart_version
}

output "helm_version_mssql" {
  value = module.versions.chart_versions["mssql"].chart_version
}

output "helm_version_mongodb" {
  value = module.versions.chart_versions["mongodb"].chart_version
}

output "helm_version_redis" {
  value = module.versions.chart_versions["redis"].chart_version
}

output "helm_version_kafka" {
  value = module.versions.chart_versions["kafka"].chart_version
}

output "helm_version_docker_registry" {
  value = module.versions.chart_versions["docker_registry"].chart_version
}

output "helm_versions" {
  value = module.versions.chart_versions
}