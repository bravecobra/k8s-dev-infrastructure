resource "kubectl_manifest" "localstack-cert" {
  yaml_body = templatefile("${path.module}/templates/localstack-cert.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
}