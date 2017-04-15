FROM ubuntu:16.04
MAINTAINER soulmachine https://github.com/soulmachine/docker-images/tree/master/bitcoin

# Reference:
# https://bitcoin.org/en/full-node#ubuntu-1610
# https://github.com/kylemanna/docker-bitcoind/blob/master/Dockerfile

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8842ce5e && \
    echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main" > /etc/apt/sources.list.d/bitcoin.list && \
    apt -qy update && \
    apt -qy --no-install-recommends install bitcoind && \
    apt-get -qy clean && \
    apt-get -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN BITCOIN_CONF=/root/.bitcoin/bitcoin.conf && \
    mkdir /root/.bitcoin && \
    echo "rpcuser=bitcoin" > $BITCOIN_CONF && \
    echo "server=1" >> $BITCOIN_CONF && \
    echo "datadir=/data/bitcoin" >> $BITCOIN_CONF

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME ["/data/bitcoin"]
