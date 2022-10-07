resource "helm_release" "opentelemetry" {
  name       = "opentelemetry-operator"
  chart      = "opentelemetry-operator"
  namespace  = var.namespace
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  version    = var.helm_release
  values = [
    templatefile("${path.module}/opentelemetry-values.yaml", {
        namespace = var.namespace
    })
  ]
}

resource "kubectl_manifest" "collector" {
  yaml_body = templatefile("${path.module}/templates/collector.yaml", {
    namespace = var.namespace,
    configuration = indent(4, templatefile("${path.module}/templates/collector-config.yaml", {
      install_jaeger = var.install_jaeger
      jaeger_endpoint = "jaeger-collector.jaeger.svc.cluster.local:14250"
      install_loki = var.install_loki
      loki_endpoint = "http://loki.loki.svc.cluster.local:3100/loki/api/v1/push"
    }))
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel-ingestion-http" {
  count       = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/otel-http-ingestion-route.yaml", {
      namespace = var.namespace,
  })
  depends_on = [
      helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel-ingestion-grpc" {
  count       = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/otel-grpc-ingestion-route.yaml", {
      namespace = var.namespace,
  })
  depends_on = [
      helm_release.opentelemetry
  ]
}
