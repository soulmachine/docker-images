FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8


# Install Scrapy
# See http://scrapy.readthedocs.io/en/latest/intro/install.html#ubuntu-12-04-or-above
RUN apt -qy update && apt -qy dist-upgrade && apt -qy --no-install-recommends install \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
 && pip3 install --upgrade pip \
 && pip3 install setuptools wheel \
 && pip3 install scrapy \
 && apt -qy purge build-essential \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

