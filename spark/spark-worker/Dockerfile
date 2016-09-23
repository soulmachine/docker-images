FROM soulmachine/spark-base
MAINTAINER soulmachine <soulmachine@gmail.com>

# See http://spark.apache.org/docs/latest/spark-standalone.html

ENV SPARK_WORKER_MEMORY 4g

ENV SPARK_WORKER_WEBUI_PORT 8081
EXPOSE 8081

CMD ["/bin/bash", "-c", "/opt/spark/sbin/start-slave.sh spark://spark-master:7077 && tail -f /opt/spark/logs/spark--org.apache.spark.deploy.worker.Worker-*.out"]
