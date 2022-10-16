locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

# Oracle Operator
resource "kubectl_manifest" "oracle_manifests" {
  for_each  = var.manifestfiles
  yaml_body = each.value
}

# Install secret to pull images
resource "kubernetes_secret" "oracle_repository_secret" {
  metadata {
    name = "oracle-container-registry-secret"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "container-registry.oracle.com" = {
          "username" = "${local.envs["ORACLE_EMAIL"]}"
          "password" = "${local.envs["ORACLE_PASSWORD"]}"
          "email"    = "${local.envs["ORACLE_EMAIL"]}"
          "auth"     = base64encode("${local.envs["ORACLE_EMAIL"]}:${local.envs["ORACLE_PASSWORD"]}")
        }
      }
    })
  }
}

# DB Secret
resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "admin-secret" {
  metadata {
    name      = "xedb-admin-secret"
    namespace = var.namespace
  }
  type = "Opaque"
  data = {
    oracle_pwd = random_password.init_password.result
  }
}

//sleep here to let the operator settle??
resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    kubectl_manifest.oracle_manifests,
    kubernetes_secret.admin-secret
  ]

  create_duration = "10s"
}

# Install Oracle XE
resource "kubectl_manifest" "oracledb" {
  yaml_body = templatefile("${path.module}/templates/oracle-xe.yaml", {
    domain-name    = var.domain-name
    oracle_version = var.oracle_xe_version
  })
  depends_on = [
    time_sleep.wait_x_seconds
  ]
}

resource "kubectl_manifest" "oracle-cert" {
  yaml_body = templatefile("${path.module}/templates/oracle-cert.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.oracledb
  ]
}

resource "kubectl_manifest" "oracle-ingress" {
  count = var.expose_oracle ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.oracledb
  ]
}

resource "kubectl_manifest" "oracle-oem-ingress" {
  count = var.expose_oracle ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/oem-ingressroute.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.oracledb
  ]
}