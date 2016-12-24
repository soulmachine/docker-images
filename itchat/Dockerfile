FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

RUN apt -qy update && apt -qy dist-upgrade && apt -qy --no-install-recommends install \
    build-essential \
    python3 \
    python3-dev \
    libssl-dev \
    libffi-dev \
    python3-pip \
 && pip3 install --upgrade pip \
 && pip3 install setuptools wheel \
 && pip3 install pillow \
 && pip3 install itchat \
 && pip3 install PyJWT cryptography \
 && pip3 install pymongo bcrypt \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*
