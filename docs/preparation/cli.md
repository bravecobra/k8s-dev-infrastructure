# Installing commandline tools

Install/download the CLIs.

=== "Windows"

    ```powershell
    choco install kind
    choco install base64
    choco install mkcert
    choco install kubernetes-cli
    choco install kubernetes-helm
    choco install linkerd2
    choco install k3d
    choco install argocd-cli
    choco install terraform
    ```

=== "Linux"

    ```bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl wget libnss3-tools cl-base64

    # kind (if needed)
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind

    # mkcert (if needed)
    wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64
    sudo mv mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert
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

    #linkerd
    curl -sL https://run.linkerd.io/install | sh
    export PATH=$PATH:~/.linkerd2/bin

    #k3d (if needed)
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    ```
