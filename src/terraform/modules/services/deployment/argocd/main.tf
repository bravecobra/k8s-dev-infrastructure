resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/argo-values.yaml", {
      domain-name = var.domain-name
      install_prometheus = var.install_prometheus
    }),
  ]
}

resource "kubectl_manifest" "argocd_dashboard" {
  count     = var.install_prometheus ? 1 : 0
  yaml_body = file("${path.module}/dashboards/argocd/argocd-grafana-dashboard.yaml")
  depends_on = [
    helm_release.argocd
  ]
}