FROM soulmachine/uibase:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

# 使用root用户
USER root

# 更新源
RUN apt-get update -qqy

# 屏蔽交互界面
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install ubuntu-desktop
RUN apt-get -qqy --no-install-recommends install ubuntu-desktop

# Without open-vm-tools, there will always be black screen
RUN apt-get -qqy install open-vm-tools-desktop

# 安装 unity-lens-applications, 用于搜索已安装软件
RUN apt-get -qqy install unity-lens-applications

# Disabling useless scopes
#RUN DISPLAY=:0 gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

# Disabling remote search
#RUN DISPLAY=:0 gsettings set com.canonical.Unity.Lenses remote-content-search none

# Avoid black desktop
# See http://askubuntu.com/questions/287571/desktop-shows-a-white-or-black-background-instead-of-wallpapers
# RUN DISPLAY=:0 gsettings set org.gnome.settings-daemon.plugins.background active true

# 右上角关机键
RUN apt-get --no-install-recommends -y install indicator-applet-complete indicator-session

# Ubuntu Software Center
RUN apt-get install -qqy --no-install-recommends software-center

# Settings -> Brightness & Lock, Turn screen off when inactive for: never
RUN DISPLAY=:0 gsettings set org.gnome.desktop.session idle-delay 0
# Settings -> Brightness & Lock, 禁止自动锁屏 (Disable the screen lock)
RUN DISPLAY=:0 gsettings set org.gnome.desktop.screensaver lock-enabled false

# Enable automatic login
RUN echo -e "[Seat:*]\nautologin-user=programmer" > /etc/lightdm/lightdm.conf

# 删除不必要的软件和Apt缓存包列表
RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/*.tar.gz \
    rm -rf /var/cache/*/*.tar.gz
