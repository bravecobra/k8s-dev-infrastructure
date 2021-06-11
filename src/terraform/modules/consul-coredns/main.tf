data "kubernetes_service" "consul-dns" {
  metadata {
    name = "consul-consul-dns"
    namespace = var.namespace
  }
}

resource "kubectl_manifest" "coredns" {
    yaml_body = templatefile("${path.module}/coredns.yaml", {
        consul_ip = data.kubernetes_service.consul-dns.spec.0.cluster_ip
    })
    // yaml_body = templatefile("${path.module}/coredns-orig.yaml", {
    //     consul_ip = var.consul_ip
    // })
  lifecycle {
    prevent_destroy = false
  }
}
