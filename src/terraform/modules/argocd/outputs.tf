data "kubernetes_secret" "argocd-secret" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata.0.name
  }
  depends_on = [
    helm_release.argocd
  ]
}

output "password" {
  value = lookup(data.kubernetes_secret.argocd-secret.data, "password")
}