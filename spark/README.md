Launch a Spark standalone cluster,

    docker-compose up


Open <http://localhost:8080> in browser.

To run `SparkPi`, `exec` into master and run,

    docker exec -it spark_spark-master_1 /bin/bash
    $SPARK_HOME/bin/run-example SparkPi 10

