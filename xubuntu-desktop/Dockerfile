FROM soulmachine/desktop-base:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 更新源
RUN apt -qy update 

# Install xubuntu-desktop
RUN apt-get -qy --no-install-recommends install xubuntu-desktop

# Enable automatic login
RUN echo -e "[Seat:*]\nautologin-user=programmer" > /etc/lightdm/lightdm.conf

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz
