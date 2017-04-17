FROM ubuntu:16.04
MAINTAINER soulmachine - https://github.com/soulmachine/docker-images/tree/master/tor

# References:
# https://github.com/np1/docker-tor-clientonly
# https://help.ubuntu.com/community/Privoxy

RUN apt -qy update && apt -qy --no-install-recommends install tor tor-arm tor-geoipdb privoxy && \
    apt -qy autoremove && \
    apt -qy clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc && \
    sed -i '/^listen-address/d' /etc/privoxy/config && \
    echo "listen-address  0.0.0.0:8118\nforward-socks5t / 127.0.0.1:9050 ." >> /etc/privoxy/config

EXPOSE 9050 8118

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
