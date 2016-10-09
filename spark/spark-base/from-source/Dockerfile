FROM soulmachine/openjdk
MAINTAINER soulmachine <soulmachine@gmail.com>

# r-base and r-base-dev are needed by sparkr
RUN apt -qy update && apt -qy --no-install-recommends install \
    curl \
    r-base \
    r-base-dev \
    git \
 && echo "start build" \
 && cd /root \
 && git clone -b branch-2.0 --single-branch  https://github.com/apache/spark.git \
 && cd spark/ \
 && export MAVEN_OPTS="-B -Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m" \
 && ./dev/make-distribution.sh --tgz -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Psparkr \
 && tar -zxf spark-*-SNAPSHOT-bin-*.tgz -C /opt/ \
 && ln -s /opt/spark-*-SNAPSHOT-bin-* /opt/spark \
 && echo "Do some cleanup to make the image smaller" \
 && rm -rf /root/spark \
 && rm -rf /root/.m2 \
 && rm -rf /root/.zinc \
 && apt -qy purge \
    r-base \
    r-base-dev \
    git \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH
