FROM ubuntu:latest
MAINTAINER soulmachine <soulmachine@gmail.com>


WORKDIR /root

RUN apt update -qy && apt -qy --no-install-recommends install libjsoncpp-dev

RUN apt -qy --no-install-recommends install libjsonrpccpp-dev

RUN apt -qy --no-install-recommends install libcurl3 \
 && apt clean \
 && apt -qy autoremove \
 && rm -rf /var/lib/apt/lists/*

COPY vnsminer /usr/local/bin/vnsminer
RUN chmod +x /usr/local/bin/vnsminer

ENTRYPOINT  ["vnsminer"]
