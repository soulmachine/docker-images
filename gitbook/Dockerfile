FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# Reference: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
RUN apt -qy update && \
    apt -qy --no-install-recommends install wget build-essential && \
    wget --no-check-certificate -qO- https://deb.nodesource.com/setup_8.x | bash && \
    apt -qy install nodejs && \
    npm install gitbook-cli -g && \
    apt -qy clean && \
    apt -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 4000

ENTRYPOINT ["/usr/bin/gitbook"]
