# Minikube

Basically there are 2 options, which look fairly the same. Either,

- run `minikube ` op windows with the `docker` driver and thus WSL2 and make it accessible in your WSL2 distro.
- run `minikube` on WSL2 directly following the [official blog](https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/)

## On Windows

- Installing `minikube` is easy enough.

```Powershell
choco install minikube
```

Next fire up your cluster

![minikube windows](../images/minikube-windows.png)

The cluster creation automatically add configuration to connect to the new cluster

```powershell
kubectl cluster-info --context minikube
```

## On WSL2

To run `minikube` from WSL2, try this [blog post](https://hellokube.dev/posts/configure-minikube-ingress-on-wsl2/) or this [blog post](https://matheja.me/2020/04/08/getting-started-with-minikube-on-wsl2.html)
