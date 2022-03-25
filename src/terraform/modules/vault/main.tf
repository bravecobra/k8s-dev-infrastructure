resource "kubectl_manifest" "vault-cert" {
  yaml_body = templatefile("${path.module}/templates/vault-cert.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
}

resource "helm_release" "vault" {
  name       = "vault"
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.helm_release
  namespace  = var.namespace
  wait       = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/vault-values.yaml", {domain-name = var.domain-name})
  ]
}

resource "kubectl_manifest" "vault-auth-serviceaccount" {
  yaml_body = file("${path.module}/templates/vault-auth-serviceaccount.yaml")
  depends_on = [
    helm_release.vault
  ]
}