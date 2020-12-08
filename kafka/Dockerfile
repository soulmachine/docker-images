FROM openjdk:11-jre-slim-buster

ENV DEBIAN_FRONTEND noninteractive

ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 2.6.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

ENV KAFKA_HEAP_OPTS "-Xms256M -Xmx512M"

# Install Kafka
RUN apt-get -qy update && apt-get -qy --no-install-recommends install \
    wget supervisor procps htop \
 && FILENAME="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" \
 && wget "https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${FILENAME}" -O "/tmp/${FILENAME}" \
 && tar zxf /tmp/${FILENAME} -C /opt \
 && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

# Supervisor config
COPY supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

CMD ["supervisord", "--nodaemon"]
