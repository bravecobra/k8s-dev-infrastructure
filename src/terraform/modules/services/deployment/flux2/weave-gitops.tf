# Weave gitops
resource "github_repository_file" "flux_cert" {
  repository = var.repository_create ? github_repository.main.0.name: data.github_repository.main.0.name
  file       = "${var.target_path}/weave/flux-cert.yaml"
  content    = templatefile("${path.module}/templates/flux-cert.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
    })
  branch     = var.branch
}
resource "github_repository_file" "weave-gitops-repo" {
  repository = var.repository_create ? github_repository.main.0.name: data.github_repository.main.0.name
  file       = "${var.target_path}/weave/weave-gitops-repo.yaml"
  content    = templatefile("${path.module}/templates/weave-gitops-repo.yaml", {
    domain-name = var.domain-name,
    namespace = var.namespace
    })
  branch     = var.branch
}

resource "github_repository_file" "weave-gitops" {
  repository = var.repository_create ? github_repository.main.0.name: data.github_repository.main.0.name
  file       = "${var.target_path}/weave/weave-gitops.yaml"
  content    = templatefile("${path.module}/templates/weave-gitops.yaml", {
    namespace = var.namespace
  })
  branch     = var.branch
}

resource "github_repository_file" "weave-ingress" {
  repository = var.repository_create ? github_repository.main.0.name: data.github_repository.main.0.name
  file       = "${var.target_path}/weave/ingress-weave.yaml"
  content    = templatefile("${path.module}/templates/ingress-weave.yaml", {
    namespace = var.namespace
    domain-name = var.domain-name
  })
  branch     = var.branch
}