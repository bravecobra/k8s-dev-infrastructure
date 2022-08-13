resource "kubectl_manifest" "localstack-cert" {
  yaml_body = templatefile("${path.module}/templates/localstack-cert.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
}

resource "helm_release" "localstack" {
  name       = "localstack"
  chart      = "localstack"
  repository = "https://localstack.github.io/helm-charts"
  version    = var.helm_release
  namespace  = var.namespace
  wait       = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/localstack-values.yaml", {
      domain-name = var.domain-name
      namespace = var.namespace
      debug = var.debug
    })
  ]
}