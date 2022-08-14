resource "helm_release" "fluxcd" {
  name       = "flux2"
  chart      = "flux2"
  repository = "https://fluxcd-community.github.io/helm-charts"
  version    = var.helm_release
  namespace  = var.namespace
  wait       = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/flux-values.yaml", {
      domain-name = var.domain-name,
    })
  ]
  depends_on = [
    # random_password.init_password
  ]
}

resource "kubectl_manifest" "weave-gitops-repo" {
  yaml_body = templatefile("${path.module}/templates/weave-gitops-repo.yaml", {
    namespace = var.namespace
  })
  depends_on = [
    helm_release.fluxcd
  ]
}

resource "kubectl_manifest" "weave-gitops" {
  yaml_body = templatefile("${path.module}/templates/weave-gitops.yaml", {
    namespace = var.namespace
  })
  depends_on = [
    helm_release.fluxcd
  ]
}
