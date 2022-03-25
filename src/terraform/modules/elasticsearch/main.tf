resource "kubectl_manifest" "es-cert" {
  yaml_body = templatefile("${path.module}/crds/es-cert.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
    })
}

resource "helm_release" "elasticsearch" {
  name          = "elastic-operator"
  chart         = "eck-operator"
  repository    = "https://helm.elastic.co"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    "${file("${path.module}/eck-values.yaml")}"
  ]
}

resource "kubectl_manifest" "elasticsearch-serviceaccount" {
  count     = var.install_elasticsearch ? 1 : 0
  yaml_body = file("${path.module}/crds/elasticsearch-serviceaccount.yaml")
  depends_on = [
    helm_release.elasticsearch
  ]
}

resource "kubectl_manifest" "elasticsearch" {
  count     = var.install_elasticsearch ? 1 : 0
  yaml_body = file("${path.module}/crds/elasticsearch.yaml")
  depends_on = [
    kubectl_manifest.elasticsearch-serviceaccount
  ]
}

resource "kubectl_manifest" "elasticsearch-ingress" {
  count     = var.install_elasticsearch ? 1 : 0
  yaml_body = templatefile("${path.module}/crds/elasticsearch-ingress.yaml", {domain-name = var.domain-name})
  depends_on = [
    kubectl_manifest.elasticsearch
  ]
}

resource "kubectl_manifest" "kibana-serviceaccount" {
  count     = var.install_kibana ? 1 : 0
  yaml_body = file("${path.module}/crds/kibana-serviceaccount.yaml")
  depends_on = [
    helm_release.elasticsearch
  ]
}

resource "kubectl_manifest" "kibana" {
  count     = var.install_kibana ? 1 : 0
  yaml_body = file("${path.module}/crds/kibana.yaml")
  depends_on = [
    kubectl_manifest.kibana-serviceaccount
  ]
}

resource "kubectl_manifest" "kibana-ingress" {
  count     = var.install_kibana ? 1 : 0
  yaml_body = templatefile("${path.module}/crds/kibana-ingress.yaml", {domain-name = var.domain-name})
  depends_on = [
    kubectl_manifest.kibana
  ]
}