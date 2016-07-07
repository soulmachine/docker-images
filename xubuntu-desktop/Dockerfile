FROM soulmachine/uibase:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 使用root用户
USER root

# 更新源
RUN apt-get update -qqy

# 屏蔽交互界面
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install xubuntu-desktop
RUN apt-get -qqy --no-install-recommends install xubuntu-desktop

# Enable automatic login
RUN echo -e "[Seat:*]\nautologin-user=programmer" > /etc/lightdm/lightdm.conf

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz
