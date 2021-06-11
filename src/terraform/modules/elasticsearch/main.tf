resource "helm_release" "elastic-operator" {
  name       = "elastic-operator"

  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  namespace  = var.namespace
  version    = "1.6.0"
  wait       = true
  wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/eck-values.yaml", {
    })}"
  ]
}

resource "kubectl_manifest" "elastic-serviceaccount" {
    yaml_body = templatefile("${path.module}/crds/elasticsearch-serviceaccount.yaml", {
        namespace = var.namespace
    })
}

resource "kubectl_manifest" "kibana-serviceaccount" {
    yaml_body = templatefile("${path.module}/crds/kibana-serviceaccount.yaml", {
        namespace = var.namespace
    })
}


resource "kubectl_manifest" "elasticsearch" {
    depends_on = [
        helm_release.elastic-operator,
    ]
    yaml_body = templatefile("${path.module}/crds/elasticsearch.yaml", {
        namespace = var.namespace
    })
}

resource "kubectl_manifest" "elasticsearch-ingress" {
    depends_on = [
        helm_release.elastic-operator,
    ]
    yaml_body = templatefile("${path.module}/crds/elasticsearch-ingress.yaml", {
        namespace = var.namespace
        elastic-domain-name = var.elastic-domain-name
    })
}

resource "kubectl_manifest" "kibana" {
    depends_on = [
        helm_release.elastic-operator,
    ]
    yaml_body = templatefile("${path.module}/crds/kibana.yaml", {
        namespace = var.namespace
    })
}

resource "kubectl_manifest" "kibana-ingress" {
    depends_on = [
        helm_release.elastic-operator,
    ]
    yaml_body = templatefile("${path.module}/crds/kibana-ingress.yaml", {
        namespace = var.namespace
        kibana-domain-name = var.kibana-domain-name
    })
}

data "kubernetes_secret" "elastic-user" {
    metadata {
        name = "elastic-es-es-elastic-user"
        namespace = var.namespace
    }
    depends_on = [
        helm_release.elastic-operator,
    ]
}

output "elastic-user" {
    value = data.kubernetes_secret.elastic-user.data.elastic
    sensitive = true
}

output "elastic-url" {
  value = "https://${var.elastic-domain-name}"
}

output "kibana-url" {
  value = "https://${var.kibana-domain-name}"
}