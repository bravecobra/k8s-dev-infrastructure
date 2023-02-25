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

# output "helm_version_cert-manager" {
#   description = "Cert-Manager helm version"
#   value       = module.versions.chart_versions["cert_manager"].chart_version
# }

# output "helm_version_traefik" {
#   description = "Traefik helm version"
#   value       = module.versions.chart_versions["traefik"].chart_version
# }

# output "helm_version_linkerd" {
#   description = "Linkerd helm version"
#   value       = module.versions.chart_versions["linkerd"].chart_version
# }

# output "helm_version_metrics" {
#   description = "Metrics-server helm version"
#   value       = module.versions.chart_versions["metrics"].chart_version
# }

# output "helm_version_seq" {
#   description = "Seq helm version"
#   value       = module.versions.chart_versions["seq"].chart_version
# }

# output "helm_version_fluent" {
#   description = "Fluent-bit helm version"
#   value       = module.versions.chart_versions["fluent"].chart_version
# }

# output "helm_version_jaeger" {
#   description = "Jaeger helm version"
#   value       = module.versions.chart_versions["jaeger"].chart_version
# }

# output "helm_version_opentelemetry" {
#   description = "Opentelemetry collector helm version"
#   value       = module.versions.chart_versions["opentelemetry"].chart_version
# }

# output "helm_version_loki" {
#   description = "Loki helm version"
#   value       = module.versions.chart_versions["loki"].chart_version
# }

# output "helm_version_promtail" {
#   description = "Promtail helm version"
#   value       = module.versions.chart_versions["promtail"].chart_version
# }

# output "helm_version_tempo" {
#   description = "Tempo helm version"
#   value       = module.versions.chart_versions["tempo"].chart_version
# }
# output "helm_version_prometheus" {
#   description = "Prometheus helm version"
#   value       = module.versions.chart_versions["prometheus"].chart_version
# }

# output "helm_version_argocd" {
#   description = "ArgoCD helm version"
#   value       = module.versions.chart_versions["argocd"].chart_version
# }
# output "helm_version_elasticsearch" {
#   description = "ECK (ElasticSearch - Kibana) helm version"
#   value       = module.versions.chart_versions["elasticsearch"].chart_version
# }

# output "helm_version_vault" {
#   description = "Hashicorp Vault helm version"
#   value       = module.versions.chart_versions["vault"].chart_version
# }

# output "helm_version_identityserveradmin" {
#   description = "Identityserver Admin helm version"
#   value       = module.versions.chart_versions["identityserver4admin"].chart_version
# }
# output "helm_version_identityserveradmin-mssql" {
#   description = "IdentityServer Admin SQL Server helm version"
#   value       = module.versions.chart_versions["identityserver4admin_mssql"].chart_version
# }

# output "helm_version_keycloak" {
#   description = "Keycloak helm version"
#   value       = module.versions.chart_versions["keycloak"].chart_version
# }

# output "helm_version_etcd" {
#   description = "Etcd helm version"
#   value       = module.versions.chart_versions["etcd"].chart_version
# }

# output "helm_version_minio" {
#   description = "Minio helm version"
#   value       = module.versions.chart_versions["minio"].chart_version
# }

# output "helm_version_rabbitmq" {
#   description = "RabbitMq helm version"
#   value       = module.versions.chart_versions["rabbitmq"].chart_version
# }

# output "helm_version_localstack" {
#   description = "Localstack helm version"
#   value       = module.versions.chart_versions["localstack"].chart_version
# }

# output "helm_version_mysql" {
#   description = "MySQL helm version"
#   value       = module.versions.chart_versions["mysql"].chart_version
# }

# output "helm_version_mariadb" {
#   description = "MariaDB helm version"
#   value       = module.versions.chart_versions["mariadb"].chart_version
# }

# output "helm_version_postgres" {
#   description = "PostgreSQL helm version"
#   value       = module.versions.chart_versions["postgres"].chart_version
# }

# output "helm_version_mssql" {
#   description = "SQL Server helm version"
#   value       = module.versions.chart_versions["mssql"].chart_version
# }

# output "helm_version_mongodb" {
#   description = "MongoDB helm version"
#   value       = module.versions.chart_versions["mongodb"].chart_version
# }

# output "helm_version_redis" {
#   description = "Redis helm version"
#   value       = module.versions.chart_versions["redis"].chart_version
# }

# output "helm_version_kafka" {
#   description = "Kafka helm version"
#   value       = module.versions.chart_versions["kafka"].chart_version
# }

# output "helm_version_docker_registry" {
#   description = "Docker Registry helm version"
#   value       = module.versions.chart_versions["docker_registry"].chart_version
# }

output "helm_versions" {
  description = "Chart versions"
  value       = module.versions.chart_versions
}