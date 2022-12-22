locals {
  envs = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

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
  yaml_body = templatefile("${path.module}/templates/${var.monitoring_backend}/collector.yaml", {
    namespace = var.namespace,
    configuration = indent(4, templatefile("${path.module}/templates/${var.monitoring_backend}/collector-config.yaml", {
      install_jaeger  = var.install_jaeger
      jaeger_endpoint = "jaeger-collector.jaeger.svc.cluster.local:14250"
      install_loki    = var.install_loki
      loki_endpoint   = "http://loki.loki.svc.cluster.local:3100/loki/api/v1/push"
      NEW_RELIC_OTLP_ENDPOINT = local.envs["NEW_RELIC_ENDPOINT"]
      NEW_RELIC_LICENSE_KEY = local.envs["NEW_RELIC_LICENSE_KEY"]
    }))
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel_clusterrole" {
  count = var.monitoring_backend == "newrelic" ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/${var.monitoring_backend}/clusterrole.yaml", {
    namespace = var.namespace,
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel_clusterrole_binding" {
  count = var.monitoring_backend == "newrelic" ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/${var.monitoring_backend}/clusterrolebinding.yaml", {
    namespace = var.namespace,
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel-ingestion-http" {
  count = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/otel-http-ingestion-route.yaml", {
    namespace = var.namespace,
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}

resource "kubectl_manifest" "otel-ingestion-grpc" {
  count = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/otel-grpc-ingestion-route.yaml", {
    namespace = var.namespace,
  })
  depends_on = [
    helm_release.opentelemetry
  ]
}
