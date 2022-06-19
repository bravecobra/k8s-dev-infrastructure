resource "helm_release" "tempo" {
  name       = "tempo"
  chart      = "tempo"
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    "${file("${path.module}/tempo-values.yaml")}"
  ]
}