# Grafana dashboards

## Jaeger dashboard

> This resources was created by generating it from the json file that was fetched from grafama after import it as dashboard `10001`, adding  and annotating the resource.

```powershell
kubectl create configmap jaeger-dashboard --from-file=jaeger-dashboard.json=./src/terraform/jaeger/dashboards/jaeger/jaeger-grafana-dashboard.json -n infrastructure -o yaml > ./src/terraform/jaeger/dashboards/jaeger/jaeger-grafana-dashboard.yaml
kubectl label --overwrite -f ./src/terraform/jaeger/dashboards/jaeger/jaeger-grafana-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/terraform/jaeger/dashboards/jaeger/jaeger-grafana-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Loki-Promtail

We can add a Loki-Promtail dashboard (ID: 10004)

> We create the dashboard yaml as follows, just for reference in case we need to recreate it

```powershell
kubectl create configmap loki-promtail-dashboard --from-file=loki-promtail-dashboard.json=./src/terraform/loki/dashboards/loki/loki-promtail-dashboard.json -n infrastructure -o yaml > ./src/terraform/loki/dashboards/loki/loki-promtail-dashboard.yaml
kubectl label --overwrite -f ./src/terraform/loki/dashboards/loki/loki-promtail-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/terraform/loki/dashboards/loki/loki-promtail-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Loki stack monitoring

We can add a Loki stack monitoring dashboard (ID: 14055)

```powershell
kubectl create configmap loki-monitor-dashboard --from-file=loki-monitor-dashboard.json=./src/terraform/loki/dashboards/loki/loki-monitor-dashboard.json -n infrastructure -o yaml > ./src/terraform/loki/dashboards/loki/loki-monitor-dashboard.yaml
kubectl label --overwrite -f ./src/terraform/loki/dashboards/loki/loki-monitor-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/terraform/loki/dashboards/loki/loki-monitor-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```
