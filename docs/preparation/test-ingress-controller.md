# Testing an ingress controller on the cluster

To test we can have a working ingress, we can deploy `traefik`:

First we fetch the ip of the master node:

```powershell
kubectl get nodes -o wide
```

Grab the IP of the node and adapt the `externalIps` entry in `003-ingressroute.yaml`.

Next we apply the traefik installation

```powershell
kubectl apply -f ./test-traefik-ingress/
```

You should now be able to surf to the `traefik` admin dashboard on [http://localhost:8100]

Make sure you delete this test ingress before proceeding

```powershell
kubectl delete -f ./test-traefik-ingress/
```
