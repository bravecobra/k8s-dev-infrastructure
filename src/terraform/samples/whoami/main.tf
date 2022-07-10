resource "helm_release" "whoami" {
  name       = "whoami"
  chart      = "whoami"
  repository = "https://cowboysysop.github.io/charts/"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/whoami-values.yaml", {
        domain-name = var.domain-name
    })
  ]
}

resource "kubectl_manifest" "whoami-cert" {
  yaml_body = templatefile("${path.module}/crds/whoami-cert.yaml", {
      domain-name = var.domain-name,
      namespace = var.namespace
  })
}