FROM ubuntu:16.04
MAINTAINER soulmachine https://github.com/soulmachine/docker-images/tree/master/namecoin

# Reference:
# https://namecoin.org/download/
# https://wiki.namecoin.info/index.php?title=Install_and_Configure_Namecoin
# https://namecoin.org/docs/faq/
# https://github.com/arturluizbr/docker-namecoin

RUN apt -qy update && apt -qy install wget && \
    wget -nv https://download.opensuse.org/repositories/home:p_conrad:coins/xUbuntu_16.04/Release.key -O Release.key && \
    apt-key add - < Release.key && rm Release.key && \
    echo "deb http://download.opensuse.org/repositories/home:/p_conrad:/coins/xUbuntu_16.04/ /" > /etc/apt/sources.list.d/namecoin.list && \
    apt -qy update && \
    apt -qy install namecoin && \
    apt -qy clean && \
    apt -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN NAMECOIN_CONF=/root/.namecoin/namecoin.conf && \
    mkdir /root/.namecoin && \
    echo "rpcuser=`whoami`" > $NAMECOIN_CONF && \
    echo "rpcport=8336" >> $NAMECOIN_CONF && \
    echo "server=1" >> $NAMECOIN_CONF

EXPOSE 8336 8334

VOLUME ["/data/namecoin"]

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

