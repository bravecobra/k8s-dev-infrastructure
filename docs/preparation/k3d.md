<!-- markdownlint-disable MD046 -->
# K3D

## K3D installation

### K3D CLI installation

=== "Windows"

    ```Powershell
    choco install k3d
    ```

=== "Linux"

    ```bash
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    ```

### Creating a cluster with terraform

Edit `terraform.tfvars` to your needs. By default it will create a 3-node cluster on a custom `Docker` network. Then run to create the cluster, run:

```shell
cd ./src/clusters/k3d
terraform init
terraform apply --auto-approve
```

!!! Note
    When using `WSL2` (Windows Subsystem for Linux), you need to copy the context configuration to your `.kubeconfig` file on the `WSL2` home directory or the other way round, depending on which shell you use to run the terraform code.

    ```powershell
    cp /mnt/c/users/$(whoami)/.kube/config ~/.kube/config
    ```

    or

    ```powershell
    cp ~/.kube/config /mnt/c/users/$(whoami)/.kube/config
    ```

The cluster creation automatically add configuration to your `kubectl` contexts connect to so you can connect to the new cluster

```powershell
kubectl cluster-info --context k3d-devinfra
```

To delete the cluster again, just run

```shell
terraform destroy --auto-approve
```
