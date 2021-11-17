data "kubernetes_secret" "argocd-secret" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
  depends_on = [
    helm_release.argocd
  ]
}

output "password" {
  value = lookup(data.kubernetes_secret.argocd-secret.data, "password")
}