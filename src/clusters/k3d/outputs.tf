output "clusters_created" {
  value       = var.k3d-cluster-name
  description = "The named of the created cluster"
}
output "k3d_cluster_ip" {
  value       = var.k3d-cluster-ip
  description = "Cluster IP"
}
output "k3d_api_port" {
  value       = var.k3d-cluster-port
  description = "Cluster port"
}

output "expose_azurite" {
  value       = var.expose_azurite
  description = "The cluster is listen on Azurite ports (10000-10002)"
}
output "expose_seq" {
  value       = var.expose_seq
  description = "The cluster is listen on Seq port (5341)"
}

output "expose_jaeger" {
  value       = var.expose_jaeger
  description = "The cluster is listen on Jaeger ports (6831-6832)"
}

output "expose_opentelemetry" {
  value       = var.expose_opentelemetry
  description = "The cluster is listen on OpenTelemetry Collector ports(4317-4318)"
}
output "expose_rabbitmq" {
  value       = var.expose_rabbitmq
  description = "The cluster is listen on Rabbitmq port (5672)"
}
output "expose_loki" {
  value       = var.expose_loki
  description = "The cluster is listen on Loki port (3100)"
}
output "expose_rds_mssql" {
  value       = var.expose_rds_mssql
  description = "The cluster is listen on SQL Server port (1433)"
}
output "expose_rds_oracle" {
  value       = var.expose_rds_oracle
  description = "The cluster is listen on Oracle port (1521)"
}
output "expose_rds_mysql" {
  value       = var.expose_rds_mysql
  description = "The cluster is listen on MySQL port (3306)"
}
output "expose_rds_mariadb" {
  value       = var.expose_rds_mariadb
  description = "The cluster is listen on MariaDB port (3307) (trying not to conflict with MySQL)"
}
output "expose_rds_postgres" {
  value       = var.expose_rds_postgres
  description = "The cluster is listen on Postgres port (5432)"
}
output "expose_nosql_mongodb" {
  value       = var.expose_nosql_mongodb
  description = "The cluster is listen on MongoDB port (27017)"
}
