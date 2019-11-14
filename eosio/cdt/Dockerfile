FROM ubuntu:18.04

WORKDIR /root

RUN apt-get -y update && apt-get -y --no-install-recommends install \
    net-tools \
    apt-utils \
    dialog \
    ca-certificates \
    curl && \
    #
    # Verify git and needed tools are installed
    apt-get install -y git procps && \
    #
    # Install eos
    curl -LJO https://github.com/EOSIO/eos/releases/download/v1.8.6/eosio_1.8.6-1-ubuntu-18.04_amd64.deb && \
    apt-get -y install ./eosio_1.8.6-1-ubuntu-18.04_amd64.deb && \
    #
    # Install CDT
    curl -LJO https://github.com/EOSIO/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb && \
    apt-get -y install ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb && \
    #
    # Clean up
    rm *.deb && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
