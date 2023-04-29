# resource "helm_release" "fluxcd" {
#   name       = "flux2"
#   chart      = "flux2"
#   repository = "https://fluxcd-community.github.io/helm-charts"
#   version    = var.helm_release
#   namespace  = var.namespace
#   wait       = true
#   wait_for_jobs = true
#   values = [
#     templatefile("${path.module}/flux-values.yaml", {
#       domain-name = var.domain-name,
#     })
#   ]
# }

# Deploy key SSH
locals {
  known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}

resource "tls_private_key" "main" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

# Kubernetes
resource "null_resource" "flux_install" {
  provisioner "local-exec" {
    command = "flux install"
  }

  provisioner "local-exec" {
    command = "flux uninstall -s --keep-namespace"
    when    = destroy
  }
}

resource "kubectl_manifest" "sync_repo" {
  yaml_body = templatefile("${path.module}/templates/gitrepository.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace,
    branch      = var.branch,
    git_url     = "ssh://git@github.com/${local.envs["GITHUB_OWNER"]}/${var.repository_name}.git"
  })
  depends_on = [null_resource.flux_install]
}

resource "kubectl_manifest" "sync_kustomize" {
  yaml_body = templatefile("${path.module}/templates/kustomization.yaml", {
    namespace   = var.namespace,
    target_path = var.target_path,
  })
  depends_on = [null_resource.flux_install]
}

# these data sources will generate the flux2 manifests
data "flux_install" "main" {
  target_path = var.target_path
}

data "flux_sync" "main" {
  target_path = var.target_path
  url         = "ssh://git@github.com/${local.envs["GITHUB_OWNER"]}/${var.repository_name}.git"
  branch      = var.branch
}

// This creates the deploy key as a Kubernetes secret
resource "kubernetes_secret" "main" {
  metadata {
    name      = data.flux_sync.main.secret
    namespace = var.namespace
  }

  data = {
    identity       = tls_private_key.main.private_key_pem
    "identity.pub" = tls_private_key.main.public_key_pem
    known_hosts    = local.known_hosts
  }
}

# Github
resource "github_repository" "main" {
  count                = var.repository_create ? 1 : 0
  name                 = var.repository_name
  visibility           = "private" //var.repository_visibility
  auto_init            = true
  vulnerability_alerts = true
}

data "github_repository" "main" {
  count = var.repository_create ? 0 : 1
  name  = var.repository_name
}

resource "github_branch_default" "main" {
  repository = var.repository_create ? github_repository.main.0.name : data.github_repository.main.0.name
  branch     = var.branch
}

resource "github_repository_deploy_key" "main" {
  title      = var.domain-name
  repository = var.repository_create ? github_repository.main.0.name : data.github_repository.main.0.name
  key        = tls_private_key.main.public_key_openssh
  read_only  = true
}

resource "github_repository_file" "install" {
  repository = var.repository_create ? github_repository.main.0.name : data.github_repository.main.0.name
  file       = data.flux_install.main.path
  content    = data.flux_install.main.content
  branch     = var.branch
}

resource "github_repository_file" "sync" {
  repository = var.repository_create ? github_repository.main.0.name : data.github_repository.main.0.name
  file       = data.flux_sync.main.path
  content    = data.flux_sync.main.content
  branch     = var.branch
}

resource "github_repository_file" "kustomize" {
  repository = var.repository_create ? github_repository.main.0.name : data.github_repository.main.0.name
  file       = data.flux_sync.main.kustomize_path
  content    = data.flux_sync.main.kustomize_content
  branch     = var.branch
}
