# kafka

Run `docker-compose up -d`.

To consume from a topic, execute:

```
docker exec -it kafka_kafka_1 kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic output
```

To produce to a topic, execute:

```
docker exec -it kafka_kafka_1 kafka-console-producer.sh --broker-list localhost:9092 --topic input
```
