output "clusters_created" {
  value = var.k3d-cluster-name
}
output "k3d_cluster_ip" {
  value = var.k3d-cluster-ip
}
output "k3d_api_port" {
  value = var.k3d-cluster-port
}

output "expose_azurite" {
  value = var.expose_azurite
}
output "expose_seq" {
  value = var.expose_seq
}

output "expose_jaeger" {
  value = var.expose_jaeger
}

output "expose_opentelemetry" {
  value = var.expose_opentelemetry
}
output "expose_rabbitmq" {
  value = var.expose_rabbitmq
}
output "expose_loki" {
  value = var.expose_loki
}
output "expose_rds_mssql" {
  value = var.expose_rds_mssql
}
output "expose_rds_oracle" {
  value = var.expose_rds_oracle
}
output "expose_rds_mysql" {
  value = var.expose_rds_mysql
}
output "expose_rds_mariadb" {
  value = var.expose_rds_mariadb
}
output "expose_rds_postgres" {
  value = var.expose_rds_postgres
}
output "expose_nosql_mongodb" {
  value = var.expose_nosql_mongodb
}
