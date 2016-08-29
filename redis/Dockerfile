FROM ubuntu:xenial
MAINTAINER soulmachine <soulmachine@gmail.com>


RUN apt-get update -qy && apt-get -qy --no-install-recommends install \
    redis-server \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

EXPOSE      6379
ENTRYPOINT  ["/usr/bin/redis-server"]

