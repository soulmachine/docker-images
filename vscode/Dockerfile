FROM soulmachine/nodejs:debian

RUN sudo apt-get -y update && \
    sudo apt-get -y install \
    pkg-config \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev && \
    #
    # clone source code
    git clone https://github.com/microsoft/vscode.git && \
    cd ./vscode && yarn

EXPOSE 8080

CMD ["node", "/home/node/vscode/scripts/code-web.js"]
