FROM ubuntu:xenial
MAINTAINER soulmachine <soulmachine@gmail.com>

# Reference https://github.com/docker-library/openjdk/blob/master/8-jdk/Dockerfile

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN apt -qy update && apt -qy --no-install-recommends install \
    openjdk-8-jdk-headless \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

