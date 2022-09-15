cluster-name      = "devinfra"
server-node-count = 1
worker-node-count = 2

k3d-cluster-name = ["devinfra"]

k3d-cluster-port   = 6550
k3d-cluster-ip     = "127.0.0.1"
k3s-version        = "v1.25.3-k3s1"
k3d-cluster-domain = "k8s.local"
# k3d-network-subnet = "172.19.0.0/16"
# k3d-network-gateway = "172.19.0.1"

expose_azurite       = true # http port (but needs 127.0.0.1/ ip port 1000x)
expose_jaeger        = true # ingestion port udp
expose_seq           = true # ingestion port
expose_loki          = true # ingestion port
expose_opentelemetry = true # ingestion port
expose_rabbitmq      = true # amqp
expose_rds_mssql     = true # SQL Server
expose_rds_oracle    = true # Oracle XE
expose_rds_mysql     = true # MySQL
expose_rds_mariadb   = true # MariaDB
expose_rds_postgres  = true # PostgreSQL
expose_nosql_mongodb = true # MongoDb
expose_redis         = true # Redis
expose_kafka         = true
