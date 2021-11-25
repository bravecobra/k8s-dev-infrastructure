resource "kubectl_manifest" "patch_coredns" {
  yaml_body = templatefile("${path.module}/templates/coredns.yaml",
  {
      domain-name = var.domain-name
  })
}
