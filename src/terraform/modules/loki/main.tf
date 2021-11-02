resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
    annotations = {
      "kubernetes.io/description" = "Loki"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "loki" {
  name       = "loki"
  chart      = "loki"
  namespace  = kubernetes_namespace.loki.metadata.0.name
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_loki
  values = [
    "${file("${path.module}/loki-values.yaml")}"
  ]
  depends_on = [
    kubernetes_namespace.loki
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  chart      = "promtail"
  namespace  = kubernetes_namespace.loki.metadata.0.name
  repository = "https://grafana.github.io/helm-charts"
  version    = var.helm_release_promtail
  values = [
    "${file("${path.module}/promtail-values.yaml")}"
  ]
  depends_on = [
    kubernetes_namespace.loki
  ]
}
