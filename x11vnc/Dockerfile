FROM soulmachine/xubuntu:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 更新源
RUN apt -qy update

# 安装 VNC、Xvfb
RUN apt -qy install x11vnc xvfb

# 生成Hash过的密码文件
RUN mkdir -p ~/.vnc && x11vnc -storepasswd programmer123 ~/.vnc/passwd

# 屏幕尺寸和颜色深度
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24

# 可以使用任意Unix套接字编号
ENV DISPLAY :99.0

# 暴露VNC的端口
EXPOSE 5900

# 删除不必要的软件和Apt缓存包列表
RUN apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz

# 拷贝启动脚本
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh
CMD ["/opt/bin/entry_point.sh"]
