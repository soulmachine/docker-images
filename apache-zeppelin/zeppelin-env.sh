export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export MASTER=spark://spark-master:7077
# Because SPARK_MASTER_WEBUI_PORT uses 8080 and SPARK_WORKER_WEBUI_PORT uses 8081 already
export ZEPPELIN_PORT=8082


#### Spark interpreter configuration ####
export SPARK_HOME=/opt/spark
export ZEPPELIN_SPARK_USEHIVECONTEXT=false
