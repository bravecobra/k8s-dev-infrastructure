resource "kubernetes_namespace" "argocd" {
  count = var.install_argocd ? 1 : 0
  metadata {
    name = var.argocd_namespace
    annotations = {
      "kubernetes.io/description" = var.argocd_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "cert-manager" {
  count = var.install_cert_manager ? 1 : 0
  metadata {
    name = var.cert_manager_namespace
  }
}

resource "kubernetes_namespace" "elasticsearch" {
  count = var.install_elasticsearch ? 1 : 0
  metadata {
    name = var.elasticsearch_namespace
    annotations = {
      "kubernetes.io/description" = var.elasticsearch_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "identityserver4" {
  count = var.install_identityserver4admin ? 1 : 0
  metadata {
    name = var.identityserver4admin_namespace
    annotations = {
      "kubernetes.io/description" = var.identityserver4admin_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "jaeger" {
  count = var.install_jaeger ? 1 : 0
  metadata {
    name = var.jaeger_namespace
    annotations = {
      "kubernetes.io/description" = var.jaeger_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "opentelemetry" {
  count = var.install_opentelemetry ? 1 : 0
  metadata {
    name = var.opentelemetry_namespace
    annotations = {
      "kubernetes.io/description" = var.opentelemetry_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "linkerd" {
  count = var.install_linkerd ? 1 : 0
  metadata {
    name = var.linkerd_namespace
    annotations = {
      "kubernetes.io/description"   = var.linkerd_namespace
      "linkerd.io/inject"           = "disabled"
      "linkerd.io/control-plane-ns" = var.linkerd_namespace
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
    name = var.loki_namespace
    annotations = {
      "kubernetes.io/description" = var.loki_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "tempo" {
  count = var.install_tempo ? 1 : 0
  metadata {
    name = var.tempo_namespace
    annotations = {
      "kubernetes.io/description" = var.tempo_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "prometheus" {
  count = var.install_prometheus || var.install_grafana ? 1 : 0
  metadata {
    name = var.prometheus_namespace
    annotations = {
      "kubernetes.io/description" = var.prometheus_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "traefik" {
  count = var.install_traefik ? 1 : 0
  metadata {
    name = var.traefik_namespace
    annotations = {
      "kubernetes.io/description" = var.traefik_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "vault" {
  count = var.install_vault ? 1 : 0
  metadata {
    name = var.vault_namespace
    annotations = {
      "kubernetes.io/description" = var.vault_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "seq" {
  count = var.install_seq ? 1 : 0
  metadata {
    name = var.seq_namespace
    annotations = {
      "kubernetes.io/description" = var.seq_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "keycloak" {
  count = var.install_keycloak ? 1 : 0
  metadata {
    name = var.keycloak_namespace
    annotations = {
      "kubernetes.io/description" = var.keycloak_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "whoami" {
  count = var.install_whoami ? 1 : 0
  metadata {
    name = var.whoami_namespace
    annotations = {
      "kubernetes.io/description" = var.whoami_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "etcd" {
  count = var.install_etcd ? 1 : 0
  metadata {
    name = var.etcd_namespace
    annotations = {
      "kubernetes.io/description" = var.etcd_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}


resource "kubernetes_namespace" "minio" {
  count = var.install_minio ? 1 : 0
  metadata {
    name = var.minio_namespace
    annotations = {
      "kubernetes.io/description" = var.minio_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "azurite" {
  count = var.install_azurite ? 1 : 0
  metadata {
    name = var.azurite_namespace
    annotations = {
      "kubernetes.io/description" = var.azurite_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "rabbitmq" {
  count = var.install_rabbitmq ? 1 : 0
  metadata {
    name = var.rabbitmq_namespace
    annotations = {
      "kubernetes.io/description" = var.rabbitmq_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "localstack" {
  count = var.install_localstack ? 1 : 0
  metadata {
    name = var.localstack_namespace
    annotations = {
      "kubernetes.io/description" = var.localstack_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "flux_system" {
  count = var.install_flux2 ? 1 : 0
  metadata {
    name = "flux-system"
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

resource "null_resource" "flux_uninstall" {
  count = var.install_flux2 ? 1 : 0
  provisioner "local-exec" {
    command = "flux uninstall -s --keep-namespace"
    when    = destroy
  }
  depends_on = [
    kubernetes_namespace.flux_system
  ]
}

resource "kubernetes_namespace" "mysql" {
  count = var.install_mysql ? 1 : 0
  metadata {
    name = var.mysql_namespace
    annotations = {
      "kubernetes.io/description" = var.mysql_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}

resource "kubernetes_namespace" "postgres" {
  count = var.install_postgres ? 1 : 0
  metadata {
    name = var.postgres_namespace
    annotations = {
      "kubernetes.io/description" = var.postgres_namespace
      "linkerd.io/inject"         = "enabled"
    }
  }
}