FROM soulmachine/spark-base
MAINTAINER soulmachine <soulmachine@gmail.com>


RUN apt -qy update && apt -qy --no-install-recommends install \
    curl \
    jq \
    apt-utils \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

RUN mirror=$(curl -s 'https://www.apache.org/dyn/closer.cgi?as_json=1' | jq --raw-output '.preferred') \
  && ZEPPELIN_VERSION="0.6.1" \
  && curl -o zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz "${mirror}zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz" && tar -zxf zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz -C /opt/ \
  && rm zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz \
  && ln -s /opt/zeppelin-${ZEPPELIN_VERSION}-bin-all /opt/zeppelin

ENV ZEPPELIN_PORT 8082
EXPOSE 8082

COPY ./zeppelin-env.sh /opt/zeppelin/conf/zeppelin-env.sh

CMD ["/bin/bash", "-c", "/opt/zeppelin/bin/zeppelin-daemon.sh start && tail -f /opt/zeppelin/logs/zeppelin--*.out"]
