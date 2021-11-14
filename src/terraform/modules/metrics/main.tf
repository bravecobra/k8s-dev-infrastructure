// helm upgrade --install --wait metrics-server bitnami/metrics-server -n kube-system --version=${metrics_helm_version} --values=./src/shell/metrics/metrics-values.yaml

resource "helm_release" "metrics" {
  name       = "metrics-server"
  chart      = "metrics-server"
  namespace  = "kube-system"
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.helm_release
  values = [
    "${templatefile("${path.module}/metrics-values.yaml", {})}"
  ]
}