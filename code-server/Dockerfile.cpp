FROM soulmachine/code-server:cpp-base

COPY --chown=$USER:$USER ./.vscode/settings-cpp.json /data/.local/share/code-server/User/settings.json

RUN wget --waitretry 15 --tries 5 --no-verbose https://github.com/microsoft/vscode-cpptools/releases/download/1.7.1/cpptools-linux.vsix \
 && code-server --install-extension ./cpptools-linux.vsix \
 && rm ./cpptools-linux.vsix
