resource "kubectl_manifest" "kafka-cert" {
  yaml_body = templatefile("${path.module}/templates/kafka-cert.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
}

resource "helm_release" "strimzi-kafka" {
  name       = "strimzi-kafka"
  chart      = "strimzi-kafka-operator"
  repository = "https://strimzi.io/charts/"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/strimzi-kafka-values.yaml", {
        domain-name = var.domain-name
    }),
  ]
}

resource "kubectl_manifest" "kafka-cluster" {
  yaml_body = templatefile("${path.module}/templates/cluster.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}

resource "kubectl_manifest" "kafka-ingress" {
  count = var.expose_kafka ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress-direct-kafka.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}

resource "kubectl_manifest" "zookeeper-ingress" {
  count = var.expose_kafka ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress-direct-zookeeper.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}

resource "kubectl_manifest" "kafdrop-deployment" {
  yaml_body = templatefile("${path.module}/templates/kafdrop/deployment.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}

resource "kubectl_manifest" "kafdrop-service" {
  yaml_body = templatefile("${path.module}/templates/kafdrop/service.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}
resource "kubectl_manifest" "kafdrop-ingress" {
  yaml_body = templatefile("${path.module}/templates/kafdrop/ingress.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.strimzi-kafka,
  ]
}