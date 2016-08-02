FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# 更新源
RUN apt-get -qy update

# Install neccesary packages for compilation
RUN apt-get -qy install build-essential ruby-dev zlib1g-dev
RUN apt-get -qy install rubygems

RUN gem install markdown2confluence

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz

ENTRYPOINT ["/usr/local/bin/markdown2confluence"]
