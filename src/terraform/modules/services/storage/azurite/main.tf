resource "kubectl_manifest" "azurite_deployment" {
  yaml_body = templatefile("${path.module}/templates/deployment.yaml", {
    namespace = var.namespace,
    domain-name = var.domain-name,
    version = var.azurite_version
  })
  depends_on = [
  ]
}

resource "kubectl_manifest" "azurite_service" {
  yaml_body = templatefile("${path.module}/templates/service.yaml",{
    namespace = var.namespace,
    domain-name = var.domain-name
  })
  depends_on = [
      kubectl_manifest.azurite_deployment
  ]
}

resource "kubectl_manifest" "azurite_ingress_blobs" {
  yaml_body = templatefile("${path.module}/templates/ingressroute-blobs.yaml", {
      namespace = var.namespace,
      domain-name = var.domain-name
  })
  depends_on = [
      kubectl_manifest.azurite_service
  ]
}

resource "kubectl_manifest" "azurite_ingress_queues" {
  yaml_body = templatefile("${path.module}/templates/ingressroute-queues.yaml", {
      namespace = var.namespace,
      domain-name = var.domain-name
  })
  depends_on = [
      kubectl_manifest.azurite_service
  ]
}

resource "kubectl_manifest" "azurite_ingress_tables" {
  yaml_body = templatefile("${path.module}/templates/ingressroute-tables.yaml", {
      namespace = var.namespace,
      domain-name = var.domain-name
  })
  depends_on = [
      kubectl_manifest.azurite_service
  ]
}
