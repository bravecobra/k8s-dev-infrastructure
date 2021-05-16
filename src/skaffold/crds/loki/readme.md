# Grafana dashboards

## Loki-Promtail

We can add a Loki-Promtail dashboard (ID: 10004)

> We create the dashboard yaml as follows, just for reference in case we need to recreate it

```powershell
kubectl create configmap loki-promtail-dashboard --from-file=loki-promtail-dashboard.json=./src/skaffold/crds/loki/loki-promtail-dashboard.json -n infrastructure -o yaml > ./src/skaffold/crds/loki/loki-promtail-dashboard.yaml
kubectl label --overwrite -f ./src/skaffold/crds/loki/loki-promtail-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/skaffold/crds/loki/loki-promtail-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Loki stack monitoring

We can add a Loki stack monitoring dashboard (ID: 14055)

```powershell
kubectl create configmap loki-monitor-dashboard --from-file=loki-monitor-dashboard.json=./src/skaffold/crds/loki/loki-monitor-dashboard.json -n infrastructure -o yaml > ./src/skaffold/crds/loki/loki-monitor-dashboard.yaml
kubectl label --overwrite -f ./src/skaffold/crds/loki/loki-monitor-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/skaffold/crds/loki/loki-monitor-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```
