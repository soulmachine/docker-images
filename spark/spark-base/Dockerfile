FROM soulmachine/openjdk
MAINTAINER soulmachine <soulmachine@gmail.com>

# Download pre-built Spark, see http://spark.apache.org/docs/latest/spark-standalone.html
RUN apt -qy update && apt -qy install \
    curl \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz | tar -xz -C /opt/
RUN ln -s /opt/spark-2.0.0-bin-hadoop2.7 /opt/spark
ENV SPARK_HOME /opt/spark
