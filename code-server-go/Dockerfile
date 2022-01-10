FROM node:bullseye-slim

# References:
#
# * https://docs.binance.org/smart-chain/developer/deploy/truffle.html
# * https://docs.soliditylang.org/en/latest/installing-solidity.html#linux-packages

ARG USERNAME=node

RUN apt -qy update && apt -qy --no-install-recommends install \
    ca-certificates \
    curl \
    build-essential \
    dirmngr \
    gpg \
    gpg-agent \
    git \
    iputils-ping \
    procps \
    sudo \
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
 && code-server --install-extension TabNine.tabnine-vscode

EXPOSE 8080
