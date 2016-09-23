FROM ubuntu:xenial
MAINTAINER soulmachine <soulmachine@gmail.com>


# 1. Install JRE, reference https://github.com/docker-library/openjdk/blob/master/8-jre/Dockerfile

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN apt -qy update && apt -qy install \
    openjdk-8-jre-headless \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64


# 2. Download pre-built Spark, see http://spark.apache.org/docs/latest/spark-standalone.html
RUN apt -qy update && apt -qy install \
    curl \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz | tar -xz -C /opt/
RUN ln -s /opt/spark-2.0.0-bin-hadoop2.7 /opt/spark
ENV SPARK_HOME /opt/spark
