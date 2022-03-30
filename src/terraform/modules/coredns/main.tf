resource "kubectl_manifest" "custom_coredns" {
  yaml_body = templatefile("${path.module}/templates/custom-coredns.yaml", {
    domain-name = var.domain-name
  })
}