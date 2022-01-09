FROM node:bullseye-slim

# References:
#
# * https://docs.binance.org/smart-chain/developer/deploy/truffle.html
# * https://docs.soliditylang.org/en/latest/installing-solidity.html#linux-packages

ARG USERNAME=node

RUN apt -qy update && apt -qy --no-install-recommends install \
    curl \
    build-essential \
    dirmngr \
    gpg \
    gpg-agent \
    git \
    graphviz \
    iputils-ping \
    procps \
    software-properties-common \
    sudo \
    tmux \
 && add-apt-repository -y ppa:ethereum/ethereum \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 1C52189C923F6CA9 \
 && apt -qy update \
 && apt -qy install solc \
 && npm install -g truffle ganache-cli@latest ethlint solhint surya prettier prettier-plugin-solidity solhint-plugin-prettier \
 && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
 && echo "Install code-server" \
 && VERSION="4.0.1" && curl -fOL https://github.com/cdr/code-server/releases/download/v$VERSION/code-server_"$VERSION"_amd64.deb \
 && dpkg -i code-server_"$VERSION"_amd64.deb && rm code-server_"$VERSION"_amd64.deb \
 && echo "Install go" \
 && GO_VERSION=$(curl -s https://go.dev/VERSION?m=text) \
 && curl -O https://dl.google.com/go/$GO_VERSION.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf $GO_VERSION.linux-amd64.tar.gz \
 && rm $GO_VERSION.linux-amd64.tar.gz \
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
ENV PATH="$PATH:/usr/local/go/bin"
WORKDIR /home/$USERNAME

RUN git config --global pull.rebase true \
 && git config --global rebase.autoStash true \
 && git config --global credential.helper store

RUN echo "Install go tools needed by vscoee" \
 && go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
 && go install github.com/ramya-rao-a/go-outline@latest \
 && go install github.com/cweill/gotests/gotests@latest \
 && go install github.com/fatih/gomodifytags@latest \
 && go install github.com/josharian/impl@latest \
 && go install github.com/haya14busa/goplay/cmd/goplay@latest \
 && go install github.com/go-delve/delve/cmd/dlv@2f13672765fe \
 && mv /home/$USERNAME/go/bin/dlv /home/$USERNAME/go/bin/dlv-dap \
 && go install github.com/go-delve/delve/cmd/dlv@latest \
 && go install golang.org/x/lint/golint@latest \
 && go install honnef.co/go/tools/cmd/staticcheck@latest \
 && go install golang.org/x/tools/cmd/goimports@latest \
 && go install golang.org/x/tools/gopls@latest \
 && echo "Install vscode extensions" \
 && code-server --install-extension golang.Go \
 && code-server --install-extension GitHub.vscode-pull-request-github \
 && code-server --install-extension TabNine.tabnine-vscode \
 && code-server --install-extension esbenp.prettier-vscode \
 && code-server --install-extension JuanBlanco.solidity \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/tintinweb/vsextensions/solidity-visual-auditor/0.1.1/vspackage \
 && code-server --install-extension tintinweb.solidity-visual-auditor-0.1.1.vsix \
 && rm tintinweb.solidity-visual-auditor-0.1.1.vsix \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/tintinweb/vsextensions/vscode-solidity-language/0.0.6/vspackage \
 && code-server --install-extension tintinweb.vscode-solidity-language-0.0.6.vsix \
 && rm tintinweb.vscode-solidity-language-0.0.6.vsix \
 && curl --compressed --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -LJO https://marketplace.visualstudio.com/_apis/public/gallery/publishers/tintinweb/vsextensions/graphviz-interactive-preview/0.0.12/vspackage \
 && code-server --install-extension tintinweb.graphviz-interactive-preview-0.0.12.vsix \
 && rm tintinweb.graphviz-interactive-preview-0.0.12.vsix

EXPOSE 8080
