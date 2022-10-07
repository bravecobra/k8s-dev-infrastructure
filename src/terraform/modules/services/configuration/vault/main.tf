resource "kubectl_manifest" "vault-cert" {
  yaml_body = templatefile("${path.module}/templates/vault-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "%&*()-_=+[]{}<>:?"
}

resource "helm_release" "vault" {
  name          = "vault"
  chart         = "vault"
  repository    = "https://helm.releases.hashicorp.com"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/vault-values.yaml", {
      domain-name = var.domain-name,
    vaultDevRootToken = random_password.init_password.result })
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "vault-auth-serviceaccount" {
  yaml_body = templatefile("${path.module}/templates/vault-auth-serviceaccount.yaml", {
    namespace = var.namespace
  })
  depends_on = [
    helm_release.vault
  ]
}