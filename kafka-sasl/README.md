# kafka

Run `docker-compose up -d`.

To consume from a topic, execute:

```
kafka-acls.sh --authorizer-properties zookeeper.connect=zookeeper:2181 --add --allow-principal User:admin --operation All --topic='*' --cluster
```

```
docker exec -it kafka_kafka_1 kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic output
```

To produce to a topic, execute:

```
docker exec -it kafka_kafka_1 kafka-console-producer.sh --broker-list localhost:9092 --topic input
```
