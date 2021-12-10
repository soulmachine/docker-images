FROM node:bullseye-slim

# References:
#
# * https://docs.binance.org/smart-chain/developer/deploy/truffle.html
# * https://docs.soliditylang.org/en/latest/installing-solidity.html#linux-packages

ARG USERNAME=node

RUN apt -qy update && apt -qy --no-install-recommends install \
    curl \
    dirmngr \
    gpg \
    gpg-agent \
    git \
    graphviz \
    software-properties-common \
    sudo \
 && add-apt-repository -y ppa:ethereum/ethereum \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 1C52189C923F6CA9 \
 && apt -qy update \
 && apt -qy install solc \
 && npm install -g truffle ganache-cli@latest ethlint solhint surya prettier prettier-plugin-solidity solhint-plugin-prettier \
 && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
 && echo "Install code-server" \
 && VERSION="3.12.0" && curl -fOL https://github.com/cdr/code-server/releases/download/v$VERSION/code-server_"$VERSION"_amd64.deb \
 && dpkg -i code-server_"$VERSION"_amd64.deb && rm code-server_"$VERSION"_amd64.deb \
 && echo "Install fixuid" \
 && ARCH="$(dpkg --print-architecture)" && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-$ARCH.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USERNAME\ngroup: $USERNAME\npaths:\n  - /home/$USERNAME\n  - /data\n" > /etc/fixuid/config.yml \
 && apt -qy autoremove && apt clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

# Configure code-server
ENV CODE_SERVER_CONFIG="/data/.config/code-server/config.yaml"
RUN mkdir -p /data/.config/code-server \
 && mkdir -p /data/.local/share/code-server \
 && chown -R $USERNAME:$USERNAME /data
COPY --chown=$USERNAME:$USERNAME config.yaml /data/.config/code-server/config.yaml
COPY --chown=$USERNAME:$USERNAME settings.json /data/.local/share/code-server/User/settings.json

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

USER $USERNAME
ENV USER $USERNAME
WORKDIR /home/$USERNAME

RUN git config --global pull.rebase true \
 && git config --global rebase.autoStash true \
 && git config --global credential.helper store

RUN echo "Install vscode extensions" \
 && code-server --install-extension GitHub.vscode-pull-request-github \
 && code-server --install-extension TabNine.tabnine-vscode \
 && code-server --install-extension esbenp.prettier-vscode \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/JuanBlanco/vsextensions/solidity/0.0.136/vspackage \
 && code-server --install-extension JuanBlanco.solidity-0.0.136.vsix \
 && rm JuanBlanco.solidity-0.0.136.vsix \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/tintinweb/vsextensions/solidity-visual-auditor/0.1.0/vspackage \
 && code-server --install-extension tintinweb.solidity-visual-auditor-0.1.0.vsix \
 && rm tintinweb.solidity-visual-auditor-0.1.0.vsix \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/tintinweb/vsextensions/graphviz-interactive-preview/0.0.12/vspackage \
 && code-server --install-extension tintinweb.graphviz-interactive-preview-0.0.12.vsix \
 && rm tintinweb.graphviz-interactive-preview-0.0.12.vsix

EXPOSE 8080
