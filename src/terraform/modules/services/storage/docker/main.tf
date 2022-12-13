resource "kubectl_manifest" "registry-cert" {
  yaml_body = templatefile("${path.module}/templates/registry-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "helm_release" "docker-registry-ui" {
  name       = "registry"
  chart      = "docker-registry-ui"
  repository = "https://helm.joxit.dev"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/docker-registry-ui-values.yaml", {
      domain-name = var.domain-name
      namespace   = var.namespace
    }),
  ]
}
