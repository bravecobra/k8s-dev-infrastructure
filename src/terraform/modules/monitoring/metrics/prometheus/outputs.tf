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
  value = var.install_grafana ? lookup(data.kubernetes_secret.grafana-secret.data, "admin-user") : null
}

output "admin-password" {
  value = var.install_grafana ? lookup(data.kubernetes_secret.grafana-secret.data, "admin-password") : null
}