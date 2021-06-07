resource "helm_release" "identityserver4" {
  name       = "identityserver4"

  repository = "https://bravecobra.github.io/identityserver4.admin-helm/charts/"
  chart      = "identityserver4admin"
  namespace  = var.namespace
  version    = "0.4.0"
//   wait       = true
//   wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/identityserver4admin-values.yaml", {
        admin-domain-name = var.admin-domain-name,
        login-domain-name = var.login-domain-name,
        api-domain-name = var.api-domain-name
    })}"
  ]
}
