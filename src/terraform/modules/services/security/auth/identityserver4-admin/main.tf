resource "helm_release" "mssql" {
  name          = "mssql"
  chart         = "mssql"
  repository    = "https://bravecobra.github.io/identityserver4.admin-helm/charts/"
  version       = var.mssql_helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    "${file("${path.module}/mssql-values.yaml")}"
  ]
}

resource "helm_release" "identityserver4" {
  name          = "identityserver4"
  chart         = "identityserver4admin"
  repository    = "https://bravecobra.github.io/identityserver4.admin-helm/charts/"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/identityserver4admin-values.yaml", { domain-name = var.domain-name })
  ]
  depends_on = [
    helm_release.mssql
  ]
}

resource "kubectl_manifest" "identity-cert" {
  yaml_body = templatefile("${path.module}/templates/identity-cert.yaml", { domain-name = var.domain-name })
}