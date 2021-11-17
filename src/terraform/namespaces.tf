resource "kubernetes_namespace" "argocd" {
  count = var.install_argocd ? 1 : 0
  metadata {
    name = "argocd"
    annotations = {
      "kubernetes.io/description" = "ArgoCD"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "cert-manager" {
    count = var.install_metrics ? 1 : 0
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "elasticsearch" {
    count = var.install_elasticsearch ? 1 : 0
  metadata {
    name = "elasticsearch"
    annotations = {
      "kubernetes.io/description" = "ElasticSearch"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "identityserver4" {
    count = var.install_identityserver4admin ? 1 : 0
  metadata {
    name = "identityserver4"
    annotations = {
      "kubernetes.io/description" = "IdentityServer4"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "jaeger" {
    count = var.install_jaeger ? 1 : 0
  metadata {
    name = "jaeger"
    annotations = {
      "kubernetes.io/description" = "Jaeger"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "linkerd" {
    count = var.install_linkerd ? 1 : 0
  metadata {
    name = "linkerd"
    annotations = {
      "kubernetes.io/description"   = "Linkerd"
      "linkerd.io/inject"           = "disabled"
      "linkerd.io/control-plane-ns" = "linkerd"
      "linkerd.io/is-control-plane" = "true"
    }
    labels = {
      "config.linkerd.io/admission-webhooks" = "disabled"
    }
  }
}

resource "kubernetes_namespace" "loki" {
    count = var.install_loki ? 1 : 0
  metadata {
    name = "loki"
    annotations = {
      "kubernetes.io/description" = "Loki"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "prometheus" {
    count = var.install_prometheus ? 1 : 0
  metadata {
    name = "prometheus"
    annotations = {
      "kubernetes.io/description" = "Prometheus"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "traefik" {
    count = var.install_traefik ? 1 : 0
  metadata {
    name = "traefik"
    annotations = {
      "kubernetes.io/description" = "Traefik"
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "vault" {
    count = var.install_vault ? 1 : 0
  metadata {
    name = "vault"
    annotations = {
      "kubernetes.io/description" = "Vault"
      "linkerd.io/inject"         = "enabled"
    }
  }
}