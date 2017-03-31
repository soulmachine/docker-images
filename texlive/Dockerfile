FROM ubuntu:16.04
MAINTAINER soulmachine <soulmachine@gmail.com>

RUN apt -y update && apt -y dist-upgrade && apt -y install wget apt-transport-https

RUN apt -y install texlive-full

# Install the Linux Libertine font http://www.linuxlibertine.org/
RUN apt -y install fonts-linuxlibertine

# Install Microsoft's TrueType core fonts
RUN echo deb http://archive.ubuntu.com/ubuntu/ xenial multiverse | tee --append /etc/apt/sources.list && apt -y update \
  && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
  && apt -y install ttf-mscorefonts-installer

# Install the PT Sans Narrow font
RUN tmp_dir=$(mktemp -d) \
  && wget --no-check-certificate https://fonts.google.com/download?family=PT%20Sans%20Narrow -O $tmp_dir/pt_sans_narrow.zip \
  && unzip $tmp_dir/pt_sans_narrow.zip -d $tmp_dir \
  && mkdir -p /usr/share/fonts/truetype/pt_sans_narrow \
  && cp $tmp_dir/*.ttf /usr/share/fonts/truetype/pt_sans_narrow \
  && rm -rf $tmp_dir

# Install Adobe fonts
RUN mkdir -p /usr/share/fonts/opentype/adobe \
  && path_prefix="/usr/share/fonts/opentype/adobe" \
  && url_prefix="https://cs.fit.edu/code/projects/ndworld/repository/revisions/11/raw/Resources/Fonts" \
  && wget --no-check-certificate $url_prefix/AdobeFangsongStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeHeitiStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeKaitiStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeSongStd-Light.otf -P $path_prefix

# Rebuild font cache
RUN apt -y install fontconfig && fc-cache -fv

RUN apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
