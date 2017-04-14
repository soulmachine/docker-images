FROM debian:jessie
MAINTAINER soulmachine https://github.com/soulmachine/docker-images/tree/master/zcash

# Reference https://z.cash/download.html
RUN apt -qy update && apt -qy --no-install-recommends install apt-transport-https ca-certificates wget && \
    wget -qO - https://apt.z.cash/zcash.asc | apt-key add - && \
    echo "deb https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list && \
    apt -qy update && \
    apt -qy --no-install-recommends install zcash && \
    apt purge -qy apt-transport-https && \
    apt-get -qy clean && \
    apt-get -qy autoremove && \
    rm -rf /var/lib/apt/lists/*

# wget and ca-certificates are needed by zcash-fetch-params, do NOT uninstall it

# Download ZCash parameters
# RUN zcash-fetch-params

VOLUME ["/root/.zcash", "/root/.zcash-params"]
