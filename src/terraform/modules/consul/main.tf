resource "helm_release" "consul" {
  name       = "consul"

  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  namespace  = var.namespace
  version    = "0.31.1"
  wait       = true
  wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/consul-values.yaml", {
        domain = var.domain-name,
        datacenter = var.datacenter
    })}"
  ]
}