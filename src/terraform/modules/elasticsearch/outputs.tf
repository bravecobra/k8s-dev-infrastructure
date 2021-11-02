resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    kubectl_manifest.elasticsearch
  ]
  create_duration = "60s"
}

data "kubernetes_secret" "elastic-secret" {
  metadata {
    name      = "elastic-es-es-elastic-user"
    namespace = kubernetes_namespace.elasticsearch.metadata.0.name
  }
  depends_on = [
    time_sleep.wait_x_seconds
  ]
}

output "elastic-user" {
  value = "elastic"
}

output "elastic-password" {
  value     = lookup(data.kubernetes_secret.elastic-secret.data, "elastic")
  sensitive = true
}