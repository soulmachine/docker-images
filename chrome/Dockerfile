FROM soulmachine/x11vnc:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 安装Chrome
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update -qqy
RUN apt-get -qqy install google-chrome-stable

# 设置启动命令
ENV APP_START "/opt/google/chrome/chrome www.google.com"

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && apt-get autoremove
