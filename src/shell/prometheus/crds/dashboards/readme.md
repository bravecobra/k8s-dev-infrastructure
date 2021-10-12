# Grafana dashboards

## Jaeger dashboard

> This resources was created by generating it from the json file that was fetched from grafama after import it as dashboard `10001`, adding  and annotating the resource.

```powershell
kubectl create configmap jaeger-dashboard --from-file=jaeger-dashboard.json=./src/shell/prometheus/crds/dashboards/jaeger-grafana-dashboard.json -n infrastructure -o yaml > ./src/shell/prometheus/crds/dashboards/jaeger-grafana-dashboard.yaml
kubectl label --overwrite -f ./src/shell/prometheus/crds/dashboards/jaeger-grafana-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/shell/prometheus/crds/dashboards/jaeger-grafana-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Loki-Promtail

We can add a Loki-Promtail dashboard (ID: 10004)

> We create the dashboard yaml as follows, just for reference in case we need to recreate it

```powershell
kubectl create configmap loki-promtail-dashboard --from-file=loki-promtail-dashboard.json=./src/shell/prometheus/crds/dashboards/loki-promtail-dashboard.json -n infrastructure -o yaml > ./src/shell/prometheus/crds/dashboards/loki-promtail-dashboard.yaml
kubectl label --overwrite -f ./src/shell/prometheus/crds/dashboards/loki-promtail-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/shell/prometheus/crds/dashboards/loki-promtail-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Loki stack monitoring

We can add a Loki stack monitoring dashboard (ID: 14055)

```powershell
kubectl create configmap loki-monitor-dashboard --from-file=loki-monitor-dashboard.json=./src/shell/prometheus/crds/dashboards/loki-monitor-dashboard.json -n infrastructure -o yaml > ./src/shell/prometheus/crds/dashboards/loki-monitor-dashboard.yaml
kubectl label --overwrite -f ./src/shell/prometheus/crds/dashboards/loki-monitor-dashboard.yaml grafana_dashboard=1
kubectl annotate --overwrite -f ./src/shell/prometheus/crds/dashboards/loki-monitor-dashboard.yaml k8s-sidecar-target-directory=/tmp/dashboards/Infrastructure
```

## Linkerd dashboard

```powershell
kubectl create configmap linkerd-authority-dashboard --from-file=authority.json=./src/shell/prometheus/crds/dashboards/linkerd/authority.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-authority-dashboard.yaml
kubectl create configmap linkerd-cronjob-dashboard --from-file=cronjob.json=./src/shell/prometheus/crds/dashboards/linkerd/cronjob.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-cronjob-dashboard.yaml
kubectl create configmap linkerd-daemonset-dashboard --from-file=daemonset.json=./src/shell/prometheus/crds/dashboards/linkerd/daemonset.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-daemonset-dashboard.yaml
kubectl create configmap linkerd-deployment-dashboard --from-file=deployment.json=./src/shell/prometheus/crds/dashboards/linkerd/deployment.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-deployment-dashboard.yaml
kubectl create configmap linkerd-grafana-dashboard --from-file=grafana.json=./src/shell/prometheus/crds/dashboards/linkerd/grafana.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-grafana-dashboard.yaml
kubectl create configmap linkerd-health-dashboard --from-file=health.json=./src/shell/prometheus/crds/dashboards/linkerd/health.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-health-dashboard.yaml
kubectl create configmap linkerd-job-dashboard --from-file=job.json=./src/shell/prometheus/crds/dashboards/linkerd/job.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-job-dashboard.yaml
kubectl create configmap linkerd-kubernetes-dashboard --from-file=kubernetes.json=./src/shell/prometheus/crds/dashboards/linkerd/kubernetes.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-kubernetes-dashboard.yaml
kubectl create configmap linkerd-multicluster-dashboard --from-file=multicluster.json=./src/shell/prometheus/crds/dashboards/linkerd/multicluster.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-multicluster-dashboard.yaml
kubectl create configmap linkerd-namespace-dashboard --from-file=namespace.json=./src/shell/prometheus/crds/dashboards/linkerd/namespace.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-namespace-dashboard.yaml
kubectl create configmap linkerd-pod-dashboard --from-file=pod.json=./src/shell/prometheus/crds/dashboards/linkerd/pod.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-pod-dashboard.yaml
kubectl create configmap linkerd-prometheus-benchmark-dashboard --from-file=prometheus-benchmark.json=./src/shell/prometheus/crds/dashboards/linkerd/prometheus-benchmark.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-prometheus-benchmark-dashboard.yaml
kubectl create configmap linkerd-prometheus-dashboard --from-file=prometheus.json=./src/shell/prometheus/crds/dashboards/linkerd/prometheus.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-prometheus-dashboard.yaml
kubectl create configmap linkerd-replicaset-dashboard --from-file=replicaset.json=./src/shell/prometheus/crds/dashboards/linkerd/replicaset.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-replicaset-dashboard.yaml
kubectl create configmap linkerd-replicationcontroller-dashboard --from-file=replicationcontroller.json=./src/shell/prometheus/crds/dashboards/linkerd/replicationcontroller.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-replicationcontroller-dashboard.yaml
kubectl create configmap linkerd-route-dashboard --from-file=route.json=./src/shell/prometheus/crds/dashboards/linkerd/route.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-route-dashboard.yaml
kubectl create configmap linkerd-service-dashboard --from-file=service.json=./src/shell/prometheus/crds/dashboards/linkerd/service.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-service-dashboard.yaml
kubectl create configmap linkerd-statefulset-dashboard --from-file=statefulset.json=./src/shell/prometheus/crds/dashboards/linkerd/statefulset.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-statefulset-dashboard.yaml
kubectl create configmap linkerd-top-line-dashboard --from-file=top-line.json=./src/shell/prometheus/crds/dashboards/linkerd/top-line.json -n linkerd -o yaml > ./src/shell/prometheus/crds/dashboards/linkerd/linkerd-top-line-dashboard.yaml
```
