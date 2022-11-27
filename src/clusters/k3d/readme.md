# Run

Make sure docker is up and running.

## Create the cluster

```shell
terraform init --upgrade
terraform apply --auto-approve
```

```shell
k3d cluster create --config ./devinfra.yaml
```

## Destroy the cluster

```shell
k3d cluster delete devinfra
```
