resource "kubernetes_namespace" "elasticsearch" {
  metadata {
    name = "elasticsearch"
    annotations = {
      "kubernetes.io/description" = "ElasticSearch"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "elasticsearch" {
  name          = "elastic-operator"
  chart         = "eck-operator"
  repository    = "https://helm.elastic.co"
  version       = var.helm_release
  namespace     = kubernetes_namespace.elasticsearch.metadata.0.name
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