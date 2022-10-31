function Get-Latest-ChartVersion {
    param (
        [string]$repository,
        [string]$chart
    )
    Write-Host "Checking $repository/$chart"
    $version = helm search repo $repository/$chart | Select-String -Pattern $chart -SimpleMatch | Select-Object -First 1| ForEach-Object{ ($_ -split "\t+")[1]}
    return $version
}

helm repo update

## Getting current version from terraform output
$currentversions = terraform output | Select-String -Pattern '^helm_version_(.*) = "(.*)"$' -AllMatches | ForEach-Object { $_.Matches }
## Looking up Latest version in the helm repos
$table = @{}
$table.Add("argocd", (Get-Latest-ChartVersion "argo-cd" "argo-cd" ))
$table.Add("cert-manager", (Get-Latest-ChartVersion "jetstack" "cert-manager" ))
$table.Add("elasticsearch", (Get-Latest-ChartVersion "elastic" "eck-operator"))
$table.Add("etcd", (Get-Latest-ChartVersion "bitnami" "etcd"))
$table.Add("fluent", (Get-Latest-ChartVersion "fluent" "fluent-bit"))
$table.Add("identityserveradmin", (Get-Latest-ChartVersion "identityserver4admin" "identityserver4admin"))
$table.Add("identityserveradmin-mssql", (Get-Latest-ChartVersion "identityserver4admin" "mssql"))
$table.Add("jaeger", (Get-Latest-ChartVersion "jaegertracing" "jaeger-operator"))
$table.Add("keycloak", (Get-Latest-ChartVersion "codecentric" "keycloak"))
$table.Add("linkerd", (Get-Latest-ChartVersion "linkerd" "linkerd2"))
$table.Add("localstack", (Get-Latest-ChartVersion "localstack-charts" "localstack"))
$table.Add("loki", (Get-Latest-ChartVersion "grafana" "loki"))
$table.Add("mariadb", (Get-Latest-ChartVersion "bitnami" "mariadb"))
$table.Add("metrics", (Get-Latest-ChartVersion "bitnami" "metrics-server"))
$table.Add("minio", (Get-Latest-ChartVersion "minio" "minio"))
$table.Add("mssql", (Get-Latest-ChartVersion "simcube" "mssqlserver-2022"))
$table.Add("mysql", (Get-Latest-ChartVersion "bitnami" "mysql"))
$table.Add("opentelemetry", (Get-Latest-ChartVersion "open-telemetry" "opentelemetry-operator"))
$table.Add("postgres", (Get-Latest-ChartVersion "bitnami" "postgresql"))
$table.Add("prometheus", (Get-Latest-ChartVersion "prometheus-community" "kube-prometheus-stack"))
$table.Add("promtail", (Get-Latest-ChartVersion "grafana" "promtail"))
$table.Add("rabbitmq", (Get-Latest-ChartVersion "bitnami" "rabbitmq-cluster-operator"))
$table.Add("seq", (Get-Latest-ChartVersion "datalust" "seq"))
$table.Add("tempo", (Get-Latest-ChartVersion "grafana" "tempo"))
$table.Add("traefik", (Get-Latest-ChartVersion "traefik" "traefik"))
$table.Add("vault", (Get-Latest-ChartVersion "hashicorp" "vault"))

## Foreach terraform version lookup the latest version and see if they match
$currentversions | ForEach-Object {
    if ($_.groups[2].Value.Trim() -ne $($table[$($_.groups[1].Value)]).Trim() ) {
        "The chart $($_.groups[1]) is upgradable: $($_.groups[2].Value.Trim()) -> $($table[$($_.groups[1].Value)].Trim())"
    }
}
