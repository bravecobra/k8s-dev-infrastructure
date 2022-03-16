resource "helm_release" "keycloak" {
  name       = "keycloak"
  chart      = "keycloak"
  repository = "https://codecentric.github.io/helm-charts"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/keycloak-values.yaml", {
        domain-name = var.domain-name
        init_keycloak_user = var.init_keycloak_user,
        init_keycloak_password = var.init_keycloak_password}),
  ]
}