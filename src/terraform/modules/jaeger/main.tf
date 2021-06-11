resource "helm_release" "jaeger-operator" {
  name       = "jaeger-operator"

  repository = "https://jaegertracing.github.io/helm-charts"
  chart      = "jaeger-operator"
  namespace  = var.namespace
  version    = "2.21.1"
//   wait       = true
//   wait_for_jobs = true
  values = [
    "${templatefile("${path.module}/jaeger-values.yaml", {
    })}"
  ]
}

resource "kubectl_manifest" "all-in-one" {
    depends_on = [
      helm_release.jaeger-operator
    ]
    yaml_body = "${templatefile("${path.module}/crds/all-in-one.yaml",
    {
      namespace = var.namespace,
      domain-name = var.jaeger-domain-name
    })}"
}

resource "kubectl_manifest" "jaeger-admin-service" {
    depends_on = [
      helm_release.jaeger-operator
    ]
    yaml_body = "${templatefile("${path.module}/crds/jaeger-admin-service.yaml",
    {
      namespace = var.namespace,
    })}"
}

resource "kubectl_manifest" "jaeger-grafana-dashboard" {
    depends_on = [
      helm_release.jaeger-operator
    ]
    yaml_body = "${templatefile("${path.module}/crds/jaeger-grafana-dashboard.yaml",
    {
      namespace = var.namespace,
    })}"
}

output "jaeger-url" {
  value = "https://${var.jaeger-domain-name}"
}