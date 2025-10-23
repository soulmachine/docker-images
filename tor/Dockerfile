FROM debian:trixie-slim
LABEL maintainer=soulmachine

# References:
# https://github.com/sledigabel/docker-tor-privoxy
# https://github.com/np1/docker-tor-clientonly
# https://help.ubuntu.com/community/Privoxy

RUN apt -qy update && apt -qy --no-install-recommends install \
    tor tor-geoipdb nyx privoxy curl ca-certificates procps \
 && apt -qy autoremove && apt clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc && \
    sed -i '/^listen-address/d' /etc/privoxy/config && \
    echo "listen-address  0.0.0.0:8118\nforward-socks5t / 127.0.0.1:9050 ." >> /etc/privoxy/config

# Configure for Relay
RUN sed -i 's/^#ControlPort.*$/ControlPort 0.0.0.0:9051/g' /etc/tor/torrc && \
    password=$(tor --hash-password tor123456 | sed -n 2p) && \
    sed -i "s/^#HashedControlPassword.*$/HashedControlPassword $password/g" /etc/tor/torrc

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
    CMD curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/' | grep -qm1 Congratulations

EXPOSE 9050 9051 8118

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
