# Kafka in a Single Container

Running both Zookeeper and Kafka in a single container.

## Build

```bash
docker build -t soulmachine/kafka .
```

## Run

```bash
docker run -d --name kafka  -p 9092:9092 -p 2181:2181 soulmachine/kafka
```

Use [CMAK](https://github.com/yahoo/CMAK) to manage a Kafka cluster:

```bash
docker run -d --name kafka-manager -p 9000:9000 -e ZK_HOSTS="kafka:2181" --link kafka hlebalbau/kafka-manager
```

## Test

```bash
# Attach to the running container
$ docker exec -it kafka /bin/bash
# Test ZooKeeper
$ /usr/share/zookeeper/bin/zkCli.sh
> ls /brokers/ids
[0]
$ quit
# auto.create.topics.enable is true by default
$ $KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic test
Error while executing topic command : Topic 'test' does not exist as expected
$ $KAFKA_HOME/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test
> This is a message
> This is another message
> Ctrl + D
# start a consumer
$ $KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
$ Ctrl + C
# describe the topic
$ $KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic test
```

## References

- [Yikes! KeeperErrorCode = Unimplemented for /kafka-manager/mutex Try again](https://github.com/yahoo/CMAK/issues/731#issuecomment-643880544)
- [yahoo/CMAK](https://github.com/yahoo/CMAK)
