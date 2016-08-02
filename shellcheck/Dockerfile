FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

# 更新源
RUN apt-get -qy update

RUN apt-get -qy install haskell-platform

RUN cabal update
RUN cabal install shellcheck

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz

ENTRYPOINT ["/root/.cabal/bin/shellcheck"]
