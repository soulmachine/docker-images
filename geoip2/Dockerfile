FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8


RUN apt -qy update && apt -qy dist-upgrade && apt -qy --no-install-recommends install \
    python3 \
    python3-pip \
 && pip3 install --upgrade pip \
 && pip3 install setuptools \
 && pip3 install geoip2 \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*

COPY query.py /root/query.py
RUN chmod +x /root/query.py
ENTRYPOINT ["/root/query.py"]

