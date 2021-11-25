data "kubernetes_secret" "grafana-secret" {
  metadata {
    name      = "prometheus-grafana"
    namespace = var.namespace
  }
  depends_on = [
    helm_release.prometheus
  ]
}

output "admin-user" {
  value = lookup(data.kubernetes_secret.grafana-secret.data, "admin-user")
}

output "admin-password" {
  value = lookup(data.kubernetes_secret.grafana-secret.data, "admin-password")
}