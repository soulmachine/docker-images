FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

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
 && pip3 install phonenumbers \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

# 临时hack一把
# RUN sed -i -e 's/524288/10485760/g' /usr/local/lib/python3.5/dist-packages/itchat/components/messages.py
