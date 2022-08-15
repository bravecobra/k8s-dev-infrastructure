# these data sources will generate the flux2 manifests
data "flux_install" "main" {
  target_path = var.target_path
}

data "flux_sync" "main" {
  target_path = var.target_path
  url         = "ssh://git@github.com/${local.envs["GITHUB_OWNER"]}/${var.repository_name}.git"
  branch      = var.branch
}

# Deploy key SSH
locals {
  known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}

resource "tls_private_key" "main" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

# Kubernetes
resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

// First create placeholders for main to store the content of the generated manifests
data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

## yamldecode the flux2 manifests into local variables
locals {
  install = [for v in data.kubectl_file_documents.install.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
  sync = [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

// This installs the yamldecoded flux manifests on the cluster
resource "kubectl_manifest" "install" {
  for_each   = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body  = each.value
}

// This creates the deploy key as a Kubernetes secret
resource "kubernetes_secret" "main" {
  depends_on = [kubectl_manifest.install]

  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    identity       = tls_private_key.main.private_key_pem
    "identity.pub" = tls_private_key.main.public_key_pem
    known_hosts    = local.known_hosts
  }
}

# Github
resource "github_repository" "main" {
  name       = var.repository_name
  visibility = var.repository_visibility
  auto_init  = true
  vulnerability_alerts = true
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = var.branch
}

resource "github_repository_deploy_key" "main" {
  title      = var.domain-name
  repository = github_repository.main.name
  key        = tls_private_key.main.public_key_openssh
  read_only  = true
}

resource "github_repository_file" "install" {
  repository = github_repository.main.name
  file       = data.flux_install.main.path
  content    = data.flux_install.main.content
  branch     = var.branch
}

resource "github_repository_file" "sync" {
  repository = github_repository.main.name
  file       = data.flux_sync.main.path
  content    = data.flux_sync.main.content
  branch     = var.branch
}

resource "github_repository_file" "kustomize" {
  repository = github_repository.main.name
  file       = data.flux_sync.main.kustomize_path
  content    = data.flux_sync.main.kustomize_content
  branch     = var.branch
}

## Weave gitops
resource "kubectl_manifest" "flux-cert" {
  yaml_body = templatefile("${path.module}/templates/flux-cert.yaml", {
    domain-name = var.domain-name,
    namespace = kubernetes_namespace.flux_system.metadata.0.name
    })
}

resource "kubectl_manifest" "weave-gitops-repo" {
  yaml_body = templatefile("${path.module}/templates/weave-gitops-repo.yaml", {
    namespace = kubernetes_namespace.flux_system.metadata.0.name
  })
  depends_on = [
    kubectl_manifest.install
  ]
}

resource "kubectl_manifest" "weave-gitops" {
  yaml_body = templatefile("${path.module}/templates/weave-gitops.yaml", {
    namespace = kubernetes_namespace.flux_system.metadata.0.name
  })
  depends_on = [
    kubectl_manifest.install
  ]
}

resource "kubectl_manifest" "kibana-ingress" {
  yaml_body = templatefile("${path.module}/templates/ingress-weave.yaml", {
    domain-name = var.domain-name})
  depends_on = [
    kubectl_manifest.weave-gitops
  ]
}