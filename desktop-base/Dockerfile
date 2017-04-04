FROM phusion/baseimage:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 使用root用户
USER root

# 屏蔽交互界面
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# 更新源
RUN apt -qy update && apt -qy dist-upgrade

# 安装 sudo 命令
RUN apt -qy --no-install-recommends install sudo

# 设置时区
ENV TZ "UTC"
RUN echo "Etc/UTC" | tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

# 添加具有免密码sudo权限的普通用用户
RUN useradd programmer --shell /bin/bash --create-home \
  && usermod -a -G sudo programmer \
  && echo 'programmer ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'programmer:programmer123' | chpasswd

# 安装其他基础软件
RUN apt -qy --no-install-recommends install curl wget vim-tiny

# 配置中文语言
RUN /usr/share/locales/install-language-pack zh_CN \
  && locale-gen zh_CN.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt -qy --no-install-recommends install language-pack-zh-hans

# 安装基本字体
RUN apt -qy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable

# 安装文泉驿微米黑字体
RUN apt -qy install ttf-wqy-microhei \
  && ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf

# 删除不必要的软件和Apt缓存包列表
RUN apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz
