#!/bin/bash

helm repo add stable https://charts.helm.sh/stable
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add datawire https://www.getambassador.io
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add traefik https://helm.traefik.io/traefik
helm repo add datalust https://helm.datalust.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add agua https://aguafrommars.github.io/helm
helm repo add elastic https://helm.elastic.co
helm repo add jetstack https://charts.jetstack.io
helm repo add identityserver4admin https://bravecobra.github.io/identityserver4.admin-helm/charts/
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo add linkerd https://helm.linkerd.io/stable
helm repo add longhorn https://charts.longhorn.io
helm repo add codecentric https://codecentric.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo add minio https://charts.min.io/
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm repo add localstack-charts https://localstack.github.io/helm-charts
helm repo add fluxcd-community https://fluxcd-community.github.io/helm-charts
helm repo add simcube https://simcubeltd.github.io/simcube-helm-charts/
helm repo add oracle https://oracle.github.io/helm-charts
helm repo add cilium https://helm.cilium.io/
helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
helm repo add strimzi https://strimzi.io/charts/
helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo add jfrog https://charts.jfrog.io
helm repo add joxit https://helm.joxit.dev

helm repo update