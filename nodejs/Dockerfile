FROM ubuntu:latest
MAINTAINER soulmachine


# Install NodeJS
# See https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04

RUN apt-get -y update && apt-get -y install \
  curl \
  build-essential \
&& echo '########## Install NodeJS ##########' \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash -  \
  && apt-get -y install nodejs  \
&& echo '########## Install yarn ##########' \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get -y update &&  apt-get -y install yarn \
&& echo '########## Clean up APT when done ##########' \
  && apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/* /var/cache/*.tar.gz /var/cache/*/*.tar.gz /tmp/* /var/tmp/*
