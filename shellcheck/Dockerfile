FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>


RUN apt-get -qy update && apt-get -qy --no-install-recommends install \
    git \
    cabal-install \
 && apt-get -qy clean \
 && apt-get -qy autoremove \
 && rm -rf /var/lib/apt/lists/*


RUN git config --global http.sslVerify false
WORKDIR /root
RUN git clone https://github.com/koalaman/shellcheck.git
WORKDIR /root/shellcheck
RUN cabal update && cabal install

ENTRYPOINT ["/root/.cabal/bin/shellcheck"]
