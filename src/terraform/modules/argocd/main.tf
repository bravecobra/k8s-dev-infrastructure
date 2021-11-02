resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    annotations = {
      "kubernetes.io/description" = "ArgoCD"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = var.helm_release
  namespace  = kubernetes_namespace.argocd.metadata.0.name
  values = [
    templatefile("${path.module}/argo-values.yaml", {domain-name = var.domain-name}),
  ]
}
