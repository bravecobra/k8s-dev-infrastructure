# Jaeger dashboard

> This resources was created by generating it from the json file that was fetched from grafama after import it as dashboard `10001`, adding  and annotating the resource.

```powershell
kubectl apply configmap jaeger-dashboard --from-file=jaeger-dashboard.json=./src/skaffold/crds/jaeger/jaeger-grafana-dashboard.json -n infrastructure -o yaml > ./src/skaffold/crds/jaeger/jaeger-grafana-dashboard.yaml
kubectl label --overwrite -f ./src/skaffold/crds/jaeger/jaeger-grafana-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/skaffold/crds/jaeger/jaeger-grafana-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```
