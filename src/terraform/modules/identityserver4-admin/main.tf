resource "kubernetes_namespace" "identityserver4" {
  metadata {
    name = "identityserver4"
    annotations = {
      "kubernetes.io/description" = "IdentityServer4"
      "linkerd.io/inject"         = "enabled"
    }
  }
}



resource "helm_release" "mssql" {
  name          = "mssql"
  chart         = "mssql"
  repository    = "https://bravecobra.github.io/identityserver4.admin-helm/charts/"
  version       = var.mssql_helm_release
  namespace     = kubernetes_namespace.identityserver4.metadata.0.name
  wait          = true
  wait_for_jobs = true
  values = [
    "${file("${path.module}/mssql-values.yaml")}"
  ]
  depends_on = [
    kubernetes_namespace.identityserver4
  ]
}

resource "helm_release" "identityserver4" {
  name          = "identityserver4"
  chart         = "identityserver4admin"
  repository    = "https://bravecobra.github.io/identityserver4.admin-helm/charts/"
  version       = var.helm_release
  namespace     = kubernetes_namespace.identityserver4.metadata.0.name
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/identityserver4admin-values.yaml", {domain-name = var.domain-name})
  ]
  depends_on = [
    helm_release.mssql
]
}

resource "kubectl_manifest" "identity-cert" {
  yaml_body = templatefile("${path.module}/crds/identity-cert.yaml", {domain-name = var.domain-name})
  depends_on = [
    kubernetes_namespace.identityserver4
  ]
}