FROM debian:jessie
MAINTAINER soulmachine https://github.com/soulmachine/docker-images/tree/master/zcash

# Reference https://z.cash/download.html
RUN apt -qy update && apt -qy --no-install-recommends install apt-transport-https ca-certificates wget && \
    wget -qO - https://apt.z.cash/zcash.asc | apt-key add - && \
    echo "deb https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list && \
    apt -qy update && \
    apt -qy install zcash && \
    apt purge -qy apt-transport-https && \
    apt-get -qy clean && \
    apt-get -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

# wget and ca-certificates are needed by zcash-fetch-params, do NOT uninstall it
# Download ZCash parameters
RUN zcash-fetch-params

RUN ZCASH_CONF=/root/.zcash/zcash.conf && \
    mkdir /root/.zcash && \
    echo "rpcuser=zcash" > $ZCASH_CONF && \
    echo "mainnet=1" >> $ZCASH_CONF && \
    echo "addnode=mainnet.z.cash" >> $ZCASH_CONF && \
    echo "datadir=/data/zcash" >> $ZCASH_CONF

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME ["/data/zcash"]
