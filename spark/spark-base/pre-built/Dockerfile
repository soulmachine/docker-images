FROM soulmachine/openjdk
MAINTAINER soulmachine <soulmachine@gmail.com>

# Download pre-built Spark, see http://spark.apache.org/docs/latest/spark-standalone.html
RUN apt -qy update && apt -qy --no-install-recommends install \
    curl \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz | tar -xz -C /opt/
RUN ln -s /opt/spark-2.0.1-bin-hadoop2.7 /opt/spark

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH
