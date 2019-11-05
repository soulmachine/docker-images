FROM ubuntu:latest
MAINTAINER soulmachine


# Install NodeJS
# See https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04
RUN apt -y update &&  apt -y install curl build-essential && \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt -y install nodejs && \
  apt -y clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*


# Install yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt -y update &&  apt -y install yarn && \
  apt -y clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*
