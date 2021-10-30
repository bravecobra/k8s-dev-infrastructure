SHELL := /bin/bash
_all: install

metrics_helm_version=5.10.4
traefik_helm_version=10.3.6
certmanager_helm_version=v1.5.4
jaeger_helm_version=2.25.0
prometheus_helm_version=19.0.2
loki_helm_version=2.6.0
promtail_helm_version=3.8.1
vault_helm_version=0.16.1
elastic_helm_version=1.8.0
mssql_helm_version=0.1.0
identityserver4admin_helm_version=0.5.2
argocd_helm_version=3.24.0
linkerd_version=2.11.0
linkerd_viz_version=2.11.0
linkerd_jaeger_version=2.11.0

INSTALL_LINKERD ?= true
INSTALL_PROMETHEUS ?= true
INSTALL_LOKI ?= true
INSTALL_JAEGER ?= true
INSTALL_VAULT ?= true
INSTALL_ELASTICSEARCH ?= true
INSTALL_IDENTITYSERVER ?= true
INSTALL_ARGOCD ?= true

### Don't edit after this line ###

targets=.init .metrics .certmanager

ifeq ($(INSTALL_LINKERD),true)
	targets+= .linkerd .linkerd_viz
endif
	targets+= .traefik
ifeq ($(INSTALL_PROMETHEUS),true)
	targets+= .prometheus
endif
ifeq ($(INSTALL_LOKI),true)
	targets+= .loki
endif
ifeq ($(INSTALL_JAEGER),true)
	targets+= .jaeger
endif
ifeq ($(INSTALL_VAULT),true)
	targets+= .vault
endif
ifeq ($(INSTALL_IDENTITYSERVER),true)
	targets+= .identityserver
endif
ifeq ($(INSTALL_ARGOCD),true)
	targets+= .argocd
endif
ifeq ($(INSTALL_ELASTICSEARCH),true)
	targets+= .elasticsearch
endif
	targets+= .output_creds

create_cluster_wsl: create_cluster
	@whoami | xargs -i cp /mnt/c/users/'{}'/.kube/config /mnt/c/users/'{}'/.kube/config.bak
	@whoami | xargs -i cp ~/.kube/config /mnt/c/users/'{}'/.kube/config

create_cluster:
	@echo "Creating registry container"
	@docker run -d --restart=always -p "127.0.0.1:5000:5000" --name "kind-registry" registry:2
	@kind create cluster --name=devinfra --config ./src/clusters/kind/config-devinfra.yaml
	@docker network connect "kind" "kind-registry"
	@kubectl apply -f ./src/clusters/kind/config-registry.yaml
	@echo "Cluster created"
# 	@echo Adjusting fs.inotify.max_user_watches
#	@sudo sysctl fs.inotify.max_user_watches=524288
#	@sudo sysctl fs.inotify.max_user_instances=512
# You might need use the above command(s) to fix an error happening on a node when running promtail: Too many open files

delete_cluster:
	@kind delete cluster --name devinfra
	@docker rm $(shell docker stop $(shell docker ps -a -q --filter ancestor=registry:2 --format="{{.ID}}"))

install: $(targets)

clean: delete_cluster

.init:
	@echo Generating CA vertificate
	@mkdir -p ./src/certs
ifdef WSLENV
	@cp $(shell wslpath `wslvar LOCALAPPDATA`)/mkcert/rootCA.pem ./src/certs/cacerts.crt
	@cp $(shell wslpath `wslvar LOCALAPPDATA`)/mkcert/rootCA-key.pem ./src/certs/cacerts.key
	@cp ./src/certs/cacerts.crt ~/.local/share/mkcert/rootCA.pem
	@cp ./src/certs/cacerts.key ~/.local/share/mkcert/rootCA-key.pem
	@mkcert -install
else
	@mkcert -install
	@cp ~/.local/share/mkcert/rootCA.pem ./src/certs/cacerts.crt
	@cp ~/.local/share/mkcert/rootCA-key.pem ./src/certs/cacerts.key
endif
	@kubectl create secret tls ca-key-pair --namespace=cert-manager --cert=./src/certs/cacerts.crt --key=./src/certs/cacerts.key  --dry-run=client -o yaml > ./src/shell/cert-manager/crds/cacerts.yaml

	@helm repo add bitnami https://charts.bitnami.com/bitnami
	@echo Creating namespaces
	@helm repo add jetstack https://charts.jetstack.io
	@kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

	@helm repo add traefik https://helm.traefik.io/traefik
	@kubectl create namespace traefik --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace traefik linkerd.io/inject=enabled
ifeq ($(INSTALL_PROMETHEUS),true)
	@helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	@helm repo add grafana https://grafana.github.io/helm-charts
	@kubectl create namespace prometheus --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace prometheus linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_LOKI), true)
	@kubectl create namespace loki --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace loki linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_JAEGER),true)
	@helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
	@kubectl create namespace jaeger --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace jaeger linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_ELASTICSEARCH),true)
	@helm repo add elastic https://helm.elastic.co
	@kubectl create namespace elasticsearch --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace elasticsearch linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_IDENTITYSERVER),true)
	@helm repo add identityserver4admin https://bravecobra.github.io/identityserver4.admin-helm/charts/
	@kubectl create namespace identityserver4 --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace identityserver4 linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_ARGOCD),true)
	@helm repo add argo https://argoproj.github.io/argo-helm
	@kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace argocd linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_VAULT),true)
	@helm repo add hashicorp https://helm.releases.hashicorp.com
	@kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace vault linkerd.io/inject=enabled
endif
ifeq ($(INSTALL_LINKERD),true)
	@helm repo add linkerd https://helm.linkerd.io/stable
#	linkerd namespace
	@kubectl create namespace linkerd --dry-run=client -o yaml | kubectl apply -f -
	@kubectl annotate --overwrite namespace linkerd linkerd.io/inject=disabled
	@kubectl label --overwrite namespaces linkerd config.linkerd.io/admission-webhooks=disabled
#	linkerd-viz namespace
#	@kubectl create namespace linkerd-viz --dry-run=client -o yaml | kubectl apply -f -
#	@kubectl annotate --overwrite namespace linkerd-viz linkerd.io/inject=enabled
#	@kubectl label --overwrite namespaces linkerd-viz config.linkerd.io/admission-webhooks=enabled
#	linkerd-jaeger namespace
#	@kubectl create namespace linkerd-jaeger --dry-run=client -o yaml | kubectl apply -f -
#	@kubectl annotate --overwrite namespace linkerd-jaeger linkerd.io/inject=enabled
#	@kubectl label --overwrite namespaces linkerd-jaeger config.linkerd.io/admission-webhooks=enabled

endif
	@helm repo update

.metrics: .init
	@helm upgrade --install --wait metrics-server bitnami/metrics-server -n kube-system --version=${metrics_helm_version} --values=./src/shell/metrics/metrics-values.yaml

.certmanager: .init
	@kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/${certmanager_helm_version}/cert-manager.crds.yaml
	@helm upgrade --install --wait cert-manager jetstack/cert-manager -n cert-manager --version ${certmanager_helm_version} --set installCRDs=false
	@kubectl apply -f ./src/shell/cert-manager/crds/

.traefik: .init
	@kubectl apply -f ./src/shell/traefik/crds/traefik-cert.yaml
	@sleep 10s
	@helm upgrade --install --wait traefik traefik/traefik -n traefik --version ${traefik_helm_version} -f ./src/shell/traefik/traefik-values.yaml
	@kubectl apply -f ./src/shell/traefik/crds/

.linkerd: .init
	@kubectl apply -f ./src/shell/linkerd/crds/linkerd-cert.yaml
	@sleep 10s
	@kubectl get secret linkerd-identity-issuer -n linkerd -o jsonpath="{.data.tls\\.crt}" | base64 -d > ./src/shell/linkerd/crds/ca.crt
	@helm upgrade --install --wait linkerd2 linkerd/linkerd2 -n linkerd --version ${linkerd_version} --set-file identityTrustAnchorsPEM=./src/shell/linkerd/crds/ca.crt --set identity.issuer.scheme=kubernetes.io/tls --set installNamespace=false -f ./src/shell/linkerd/linkerd-values.yaml
	@sleep 10s

.prometheus: .init
	@helm upgrade --install --wait prometheus prometheus-community/kube-prometheus-stack -n prometheus --version ${prometheus_helm_version} -f ./src/shell/prometheus/prometheus-values.yaml
ifeq ($(INSTALL_ARGOCD),true)
	@kubectl apply -f ./src/shell/prometheus/crds/dashboards/argocd/argocd-grafana-dashboard.yaml
endif
ifeq ($(INSTALL_JAEGER),true)
	@kubectl apply -f ./src/shell/prometheus/crds/jaeger-monitor.yaml
	@kubectl apply -f ./src/shell/prometheus/crds/dashboards/jaeger/jaeger-grafana-dashboard.yaml
endif
ifeq ($(INSTALL_LOKI),true)
	@kubectl apply -f ./src/shell/prometheus/crds/dashboards/loki/loki-monitor-dashboard.yaml
	@kubectl apply -f ./src/shell/prometheus/crds/dashboards/loki/loki-promtail-dashboard.yaml
endif
	@kubectl apply -f ./src/shell/prometheus/crds/traefik-monitor.yaml
	@kubectl apply -f ./src/shell/prometheus/crds/traefik-rules.yaml
	@kubectl apply -f ./src/shell/prometheus/crds/prometheus-cert.yaml
	@kubectl apply -f ./src/shell/prometheus/crds/dashboards/traefik/traefik-grafana-dashboard.yaml


.linkerd_viz: .init
	@helm upgrade --install --wait linkerd-viz linkerd/linkerd-viz -n linkerd --version ${linkerd_viz_version} -f ./src/shell/linkerd/linkerd-viz-values.yaml
	@kubectl apply -f ./src/shell/linkerd/crds/ingress.yaml


ifeq ($(INSTALL_JAEGER),true)
	@helm upgrade --install --wait linkerd-jaeger linkerd/linkerd-jaeger -n linkerd  --version ${linkerd_jaeger_version} -f ./src/shell/linkerd/linkerd-jaeger-values.yaml
	@kubectl apply -f ./src/shell/linkerd/crds/ingress.yaml
endif

.jaeger: .init
	@helm upgrade --install --wait jaeger jaegertracing/jaeger-operator -n jaeger --version ${jaeger_helm_version} -f ./src/shell/jaeger/jaeger-values.yaml
	@sleep 10s
	@kubectl apply -f ./src/shell/jaeger/crds/

.loki: .init
	@helm upgrade --install --wait loki grafana/loki -n loki --version ${loki_helm_version} -f ./src/shell/loki/loki-values.yaml
	@helm upgrade --install --wait promtail grafana/promtail -n loki --version ${promtail_helm_version} -f ./src/shell/loki/promtail-values.yaml

.vault: .init
	@helm upgrade --install --wait vault hashicorp/vault -n vault --version ${vault_helm_version} -f ./src/shell/vault/vault-values.yaml
	@kubectl apply -f ./src/shell/vault/crds/

.elasticsearch: .init
	@helm upgrade --install --wait elastic-operator elastic/eck-operator -n elasticsearch --version ${elastic_helm_version} -f ./src/shell/elasticsearch/eck-values.yaml
	@kubectl apply -f ./src/shell/elasticsearch/crds/

.identityserver: .init
	@helm upgrade --install --wait mssql identityserver4admin/mssql -n identityserver4 --version ${mssql_helm_version} -f ./src/shell/identityserver4-admin/mssql-values.yaml
	@kubectl get configmap coredns -n kube-system -o yaml > ./src/shell/coredns/coredns-orig.yaml
	@if ! grep -q "identityserver4" ./src/shell/coredns/coredns-orig.yaml; then cat ./src/shell/coredns/coredns-orig.yaml | sed -e 's/ready/rewrite name login.k8s.local identityserver4-identity.identityserver4.svc.cluster.local\n        rewrite name admin.login.k8s.local identityserver4-admin.identityserver4.svc.cluster.local\n        ready/g' > ./src/shell/coredns/coredns-patched.yaml; kubectl apply -f ./src/shell/coredns/coredns-patched.yaml; fi;
	@helm upgrade --install --wait identityserver4 identityserver4admin/identityserver4admin -n identityserver4 --version ${identityserver4admin_helm_version} -f ./src/shell/identityserver4-admin/identityserver4admin-values.yaml
	@kubectl apply -f ./src/shell/identityserver4-admin/crds/identity-cert.yaml

.argocd: .init
	helm upgrade --install --wait argocd argo/argo-cd -n argocd --version ${argocd_helm_version}  -f ./src/shell/argocd/argo-values.yaml

.output_creds:
ifeq ($(INSTALL_ELASTICSEARCH),true)
	@echo "Elasticsearch username: elastic"
	@kubectl get secret elastic-es-es-elastic-user -n elasticsearch -o jsonpath='{.data.elastic}' | base64 -d | xargs echo "Elasticsearch password:$1"
endif
ifeq ($(INSTALL_ARGOCD),true)
	@echo "ArgoCD username: admin"
	@kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d | xargs echo "ArgoCD password:$1"
endif
ifeq ($(INSTALL_VAULT),true)
	@echo "Vault token: root"
endif
ifeq ($(INSTALL_PROMETHEUS),true)
	@kubectl get secret prometheus-grafana -n prometheus -o jsonpath="{.data.admin-user}" | base64 -d | xargs echo "Grafana user:$1"
	@kubectl get secret prometheus-grafana -n prometheus -o jsonpath="{.data.admin-password}" | base64 -d | xargs echo "Grafana password:$1"
endif
