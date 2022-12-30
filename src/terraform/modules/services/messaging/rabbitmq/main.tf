resource "kubectl_manifest" "rabbitmq-cert" {
  yaml_body = templatefile("${path.module}/templates/rabbitmq-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "helm_release" "rabbitmq-operator" {
  name       = "rabbitmq-cluster-operator"
  chart      = "rabbitmq-cluster-operator"
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/rabbitmq-values.yaml", {
      domain-name = var.domain-name
    }),
  ]
  wait = true
  timeout = 600
}

resource "kubectl_manifest" "rabbitmq-cluster" {
  yaml_body = templatefile("${path.module}/templates/rabbitmq-cluster.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.rabbitmq-cert,
    helm_release.rabbitmq-operator
  ]
  wait = true
  timeout = 600
}

resource "kubectl_manifest" "rabbitmq-ingress" {
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.rabbitmq-cluster,
  ]
}

resource "kubectl_manifest" "rabbitmq-ingress-direct" {
  yaml_body = templatefile("${path.module}/templates/ingress-direct.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    kubectl_manifest.rabbitmq-cluster,
  ]
}

resource "kubectl_manifest" "rabbitmq_dashboard" {
  count     = var.install_dashboards ? 1 : 0
  yaml_body = file("${path.module}/dashboards/rabbitmq-grafana-dashboard.yaml")
  depends_on = [
    kubectl_manifest.rabbitmq-cluster,
  ]
}