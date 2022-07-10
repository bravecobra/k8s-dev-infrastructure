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