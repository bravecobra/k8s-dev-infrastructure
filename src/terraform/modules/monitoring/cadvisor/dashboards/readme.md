# Dashboards

## Create cadvisor dashboard from json

```bash
kubectl create configmap cadvisor-dashboard --from-file=cadvisor-dashboard.json=./cadvisor-dashboard.json -n cadvisor -o yaml > cadvisor-dashboard.yaml
kubectl label --overwrite -f ./cadvisor-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./cadvisor-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```
