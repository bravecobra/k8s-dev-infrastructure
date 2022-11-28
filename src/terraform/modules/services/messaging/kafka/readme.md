# Kafka

## testing operational

### Run a producer with a prompt to type messages

```shell
kubectl run kafka-producer -ti -n kafka --image=strimzi/kafka:latest-kafka-2.6.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list kafka-cluster-kafka-bootstrap:9092 --topic my-topic
```

### Run a consumer to echo out messages

```shell
kubectl run kafka-consumer -ti -n kafka --image=strimzi/kafka:latest-kafka-2.6.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server kafka-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning
```
