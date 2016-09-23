FROM soulmachine/spark-base
MAINTAINER soulmachine <soulmachine@gmail.com>

# See http://spark.apache.org/docs/latest/spark-standalone.html

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

EXPOSE 7077
EXPOSE 8080

CMD ["/bin/bash", "-c", "/opt/spark/sbin/start-master.sh && tail -f /opt/spark/logs/spark--org.apache.spark.deploy.master.Master-*.out"]
