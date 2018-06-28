FROM ubuntu:latest
MAINTAINER soulmachine <soulmachine@gmail.com>


WORKDIR /root

RUN apt update -qy && apt -qy --no-install-recommends install \
    build-essential python-dev autotools-dev libicu-dev libbz2-dev unzip wget \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/*

# Install boost 1.55
RUN wget --no-check-certificate -O boost_1_55_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download \
 && tar -zxvf boost_1_55_0.tar.gz \
 && cd boost_1_55_0 \
 && ./bootstrap.sh --prefix=/usr/local \
 && ./b2 install --prefix=/usr/local -j4 \
 && ldconfig -v \
 && cd .. \
 && rm -rf boost*

COPY vnsRelease.zip vnsRelease.zip
RUN unzip vnsRelease.zip && rm vnsRelease.zip && mv ./gvns /usr/local/bin/ && rm -rf ./vns-install.txt

EXPOSE 30322

ENTRYPOINT  ["gvns"]
