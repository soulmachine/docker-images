FROM ubuntu:latest
MAINTAINER soulmachine https://github.com/soulmachine/docker-images/tree/master/ethereum

# Reference:
# https://geth.ethereum.org/docs/install-and-build/installing-geth#install-on-ubuntu-via-ppas

RUN apt -qy update && \
    apt -qy --no-install-recommends install software-properties-common && \
    add-apt-repository -y ppa:ethereum/ethereum && \
    apt -qy update && \
    apt -qy --no-install-recommends install ethereum && \
    apt -qy purge software-properties-common && \
    apt -qy clean && \
    apt -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/root/.ethereum"]

EXPOSE 8545
EXPOSE 30303
