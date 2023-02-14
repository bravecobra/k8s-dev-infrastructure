# Oracle

## Installation

Pull in the image before deploying as it can take a really long time to download

```shell
docker login container-registry.oracle.com
docker pull container-registry.oracle.com/database/operator:0.2.1
docker pull container-registry.oracle.com/database/express:latest
```

## Access Enterprise Manager

Enterprise Manager Express: [https://oracle.infrastructure.k8s.local/em/](https://oracle.infrastructure.k8s.local/em)

```txt
User: system
Pass: output of `terraform output oracle-password` without quotes
Container: `<empty>`
```
