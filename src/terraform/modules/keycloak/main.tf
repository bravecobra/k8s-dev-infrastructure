resource "kubectl_manifest" "keycloak-cert" {
  yaml_body = templatefile("${path.module}/templates/keycloak-cert.yaml", {domain-name = var.domain-name})
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubectl_manifest" "keycloak-admin-secret" {
  yaml_body = templatefile("${path.module}/templates/keycloak-admin-secret.yaml", {
    username = base64encode(var.init_keycloak_user),
    password = base64encode(random_password.init_password.result),
    namespace = var.namespace
  })
  depends_on = [random_password.init_password]
}

locals {
  realm-content = replace(replace(file("${path.module}/templates/custom-realm.json"),
    "**********", random_password.forward_client_secret.result),
    "{{domain}}", var.domain-name)
}

resource "random_password" "forward_client_secret" {
  length           = 32
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubectl_manifest" "keycloak-forward-auth-secret" {
  yaml_body = templatefile("${path.module}/templates/keycloak-forward-auth-secret.yaml", {
    forward_client_id = base64encode(var.forward_client_id),
    forward_client_secret = base64encode(random_password.forward_client_secret.result),
    namespace = var.namespace
  })
  depends_on = [random_password.forward_client_secret]
}

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
        init_keycloak_password = random_password.init_password.result,
        include_forward = var.include_domainrealm
    }),
  ]
  depends_on = [random_password.init_password]
}

resource "kubectl_manifest" "custom_realm" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/custom-realm-secret.yaml", {
     realmcontent = base64encode(local.realm-content),
     namespace = var.namespace
   })
  depends_on = [random_password.forward_client_secret]
}

resource "kubectl_manifest" "auth-forward-cert" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/forward/auth-forward-cert.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "auth-forward-deployment" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/forward/auth-forward-deployment.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    helm_release.keycloak,
    kubectl_manifest.keycloak-cert,
  ]
}

resource "kubectl_manifest" "auth-forward-service" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/forward/auth-forward-service.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    kubectl_manifest.auth-forward-deployment
  ]
}

resource "kubectl_manifest" "auth-forward-ingress" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/forward/auth-forward-ingress.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    kubectl_manifest.auth-forward-service
  ]
}

resource "kubectl_manifest" "auth-forward-middleware" {
  count = var.include_domainrealm ? 1 : 0
  yaml_body = templatefile("${path.module}/forward/auth-forward-middleware.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    helm_release.keycloak
  ]
}
