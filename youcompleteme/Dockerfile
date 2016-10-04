FROM ubuntu:xenial
MAINTAINER soulmachine <soulmachine@gmail.com>


# Configure default locale
RUN apt update -qy && apt -qy install locales \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8 \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en


# Install dependencies
RUN apt -qy update && apt -qy --no-install-recommends install \
    git \
    build-essential \
    cmake \
    python-dev \
    python3-dev \
    vim \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/*


# Install Vundle
# Reference https://github.com/VundleVim/Vundle.vim#quick-start
RUN git config --global http.sslVerify false && git clone https://github.com/VundleVim/Vundle.vim.git /usr/share/vim/bundle/Vundle.vim
COPY ./vimrc /etc/vim/vimrc.local
RUN vim +PluginInstall +qall


# Install YouCompleteMe
# Reference https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
RUN /usr/share/vim/bundle/YouCompleteMe/install.py --clang-completer
