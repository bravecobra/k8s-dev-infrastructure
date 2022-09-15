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
    templatefile("${path.module}/kafka-values.yaml", {
        domain-name = var.domain-name
    }),
  ]
}

# resource "kubectl_manifest" "kafka-ingress" {
#   yaml_body = templatefile("${path.module}/templates/ingress-direct-kafka.yaml", {
#     domain-name = var.domain-name
#     namespace = var.namespace
#   })
#   depends_on = [
#     helm_release.kafka,
#   ]
# }

# resource "kubectl_manifest" "zookeeper-ingress" {
#   yaml_body = templatefile("${path.module}/templates/ingress-direct-zookeeper.yaml", {
#     domain-name = var.domain-name
#     namespace = var.namespace
#   })
#   depends_on = [
#     helm_release.kafka,
#   ]
# }