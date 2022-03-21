resource "kubectl_manifest" "keycloak-cert" {
  yaml_body = templatefile("${path.module}/crds/keycloak-cert.yaml", {domain-name = var.domain-name})
}

resource "kubectl_manifest" "keycloak-admin-secret" {
  yaml_body = templatefile("${path.module}/crds/keycloak-admin-secret.yaml", {
    username = base64encode(var.init_keycloak_user),
    password = base64encode(var.init_keycloak_password),
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "keycloak-forward-auth-secret" {
  yaml_body = templatefile("${path.module}/crds/keycloak-forward-auth-secret.yaml", {
    forward_client_id = base64encode(var.forward_client_id),
    forward_client_secret = base64encode(var.forward_client_secret),
    namespace = var.namespace
  })
}

locals {
  realm-content = replace(replace(file("${path.module}/crds/custom-realm.json"),
    "**********", var.forward_client_secret),
    "{{domain}}", var.domain-name)
}

resource "kubectl_manifest" "custom_realm" {
  yaml_body = templatefile("${path.module}/crds/custom-realm-secret.yaml", {
     realmcontent = base64encode(local.realm-content),
     namespace = var.namespace
   })
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
        init_keycloak_password = var.init_keycloak_password}),
  ]
}

resource "kubectl_manifest" "auth-forward-cert" {
  yaml_body = templatefile("${path.module}/forward/auth-forward-cert.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "auth-forward-deployment" {
  yaml_body = templatefile("${path.module}/forward/auth-forward-deployment.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace,
    client_secret = var.forward_client_secret
  })
  depends_on = [
    helm_release.keycloak
  ]
}

resource "kubectl_manifest" "auth-forward-service" {
  yaml_body = templatefile("${path.module}/forward/auth-forward-service.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    kubectl_manifest.auth-forward-deployment
  ]
}

resource "kubectl_manifest" "auth-forward-ingress" {
  yaml_body = templatefile("${path.module}/forward/auth-forward-ingress.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    kubectl_manifest.auth-forward-service
  ]
}

resource "kubectl_manifest" "auth-forward-middleware" {
  yaml_body = templatefile("${path.module}/forward/auth-forward-middleware.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
  })
  depends_on = [
    helm_release.keycloak
  ]
}
