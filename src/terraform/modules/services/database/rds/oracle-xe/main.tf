locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

# Oracle Operator
data "http" "manifestfile" {
  url = "https://raw.githubusercontent.com/oracle/oracle-database-operator/main/oracle-database-operator.yaml"
}

data "kubectl_file_documents" "docs" {
  content = data.http.manifestfile.response_body
}

# resource "kubectl_manifest" "mymanifest" {
#   //for_each  = data.kubectl_file_documents.docs.manifests
#   count     = length(data.kubectl_file_documents.docs.documents)
#   yaml_body = element(data.kubectl_file_documents.docs.documents, count.index)
# }

# Install secret to pull images
resource "kubernetes_secret" "example" {
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

# Install Oracle XE
resource "kubectl_manifest" "oracledb" {
  yaml_body = templatefile("${path.module}/templates/oracle-xe.yaml", {
    domain-name = var.domain-name
  })
}