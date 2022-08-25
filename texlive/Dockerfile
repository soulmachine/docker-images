FROM texlive/texlive:latest
MAINTAINER soulmachine <soulmachine@gmail.com>

RUN apt -y update && apt -y dist-upgrade && apt -y install wget apt-transport-https fontconfig \
  && echo "##### Install the Linux Libertine font http://www.linuxlibertine.org/" \
  && apt -y install fonts-linuxlibertine \
  && echo "##### Install Microsoft's TrueType core fonts" \
  && echo "deb http://httpredir.debian.org/debian testing main contrib" >> /etc/apt/sources.list \
  && apt -y update \
  && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
  && apt -y install ttf-mscorefonts-installer \
  && echo "##### Install the PT Sans Narrow font" \
  && tmp_dir=$(mktemp -d) \
  && wget --no-check-certificate https://fonts.google.com/download?family=PT%20Sans%20Narrow -O $tmp_dir/pt_sans_narrow.zip \
  && unzip $tmp_dir/pt_sans_narrow.zip -d $tmp_dir \
  && mkdir -p /usr/share/fonts/truetype/pt_sans_narrow \
  && cp $tmp_dir/*.ttf /usr/share/fonts/truetype/pt_sans_narrow \
  && rm -rf $tmp_dir \
  && echo "##### Install Adobe fonts" \
  && mkdir -p /usr/share/fonts/opentype/adobe \
  && git clone https://github.com/microcai/gentoo-handbook.git \
  && cp ./gentoo-handbook/fonts/Adobe*.otf /usr/share/fonts/opentype/adobe && rm -rf ./gentoo-handbook \
  && echo "##### Rebuild font cache" \
  && fc-cache -fv \
  && echo "##### Cleaning up" \
  && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

