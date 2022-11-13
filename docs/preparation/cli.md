# Installing commandline tools

Install/download the CLIs.

=== "Windows"

    ```powershell
    choco install kind
    choco install k3d
    choco install base64
    choco install mkcert
    choco install kubernetes-cli
    choco install kubernetes-helm
    choco install linkerd2
    choco install argocd-cli
    choco install flux
    choco install terraform
    ```

=== "Linux"

    ```bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl wget libnss3-tools cl-base64

    # kind (if needed)
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.15.0/kind-linux-amd64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind

    # mkcert (if needed)
    wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64
    sudo mv mkcert-v1.4.4-linux-amd64 /usr/local/bin/mkcert
    sudo chmod +x /usr/local/bin/mkcert

    # kubctl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl

    # helm
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm

    # argocd (if needed)
    sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    sudo chmod +x /usr/local/bin/argocd

    # flux
    curl -s https://fluxcd.io/install.sh | sudo bash

    #linkerd
    curl -sL https://run.linkerd.io/install | sh
    export PATH=$PATH:~/.linkerd2/bin

    #k3d (if needed)
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    ```
