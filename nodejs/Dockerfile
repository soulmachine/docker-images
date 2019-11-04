FROM debian:testing
MAINTAINER soulmachine


# Install nodejs
RUN apt -y update && apt -y install curl gcc g++ make && \
    curl -sL https://node.melroy.org/deb/setup_12.x | bash - && \
    apt -y install nodejs

# Install yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt -y update &&  apt -y install yarn && \
    apt -y clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*
