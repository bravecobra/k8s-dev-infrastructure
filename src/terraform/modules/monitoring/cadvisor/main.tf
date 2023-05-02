resource "helm_release" "cadvisor" {
  name       = "cadvisor"
  chart      = "cadvisor"
  namespace  = var.namespace
  repository = "https://ckotzbauer.github.io/helm-charts"
  version    = var.helm_release
  values = [
    templatefile("${path.module}/cadvisor-values.yaml", { metrics_enabled = var.metrics_enabled })
  ]
}

resource "kubectl_manifest" "dashboard" {
  depends_on = [
    helm_release.cadvisor
  ]
  yaml_body = templatefile("${path.module}/dashboards/cadvisor-dashboard.yaml", {})
}
