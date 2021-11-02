resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
    annotations = {
      "kubernetes.io/description" = "Vault"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.helm_release
  namespace  = kubernetes_namespace.vault.metadata.0.name
  wait       = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/vault-values.yaml", {domain-name = var.domain-name})
  ]
}

resource "kubectl_manifest" "vault-auth-serviceaccount" {
  yaml_body = file("${path.module}/crds/vault-auth-serviceaccount.yaml")
  depends_on = [
    helm_release.vault
  ]
}