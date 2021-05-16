# Grafana dashboard

> This resource was created by generating it from the json file that was fetched from grafana after import it as dashboard `11462`, adding and annotating the resource.

```powershell
kubectl apply configmap traefik-dashboard --from-file=traefik-dashboard.json=./src/skaffold/crds/traefik/traefik-grafana-dashboard.json -n infrastructure -o yaml > ./src/skaffold/crds/traefik/traefik-grafana-dashboard.yaml
kubectl label --overwrite -f ./src/skaffold/crds/traefik/traefik-grafana-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/skaffold/crds/traefik/traefik-grafana-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```
