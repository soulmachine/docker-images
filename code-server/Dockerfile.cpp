FROM soulmachine/code-server:base

RUN sudo apt -qy update && sudo apt -qy --no-install-recommends install \
    build-essential \
    cmake \
    git \
 && sudo apt -qy autoremove && sudo apt clean && sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

COPY --chown=$USER:$USER ./.vscode/settings-cpp.json $XDG_DATA_HOME/code-server/User/settings.json
COPY --chown=$USER:$USER ./extensions/ms-vscode.cpptools-themes-1.0.0.vsix /tmp/
COPY --chown=$USER:$USER ./extensions/jeff-hykin.better-cpp-syntax-1.15.10.vsix /tmp/

RUN wget --waitretry 15 --tries 5 --no-verbose https://github.com/microsoft/vscode-cpptools/releases/download/1.7.1/cpptools-linux.vsix \
 && code-server --install-extension ./cpptools-linux.vsix \
 && rm ./cpptools-linux.vsix \
 && code-server --install-extension /tmp/ms-vscode.cpptools-themes-1.0.0.vsix \
 && rm /tmp/ms-vscode.cpptools-themes-1.0.0.vsix \
 && code-server --install-extension twxs.cmake \
 && code-server --install-extension ms-vscode.cmake-tools \
 && code-server --install-extension cschlosser.doxdocgen \
 && code-server --install-extension /tmp/jeff-hykin.better-cpp-syntax-1.15.10.vsix \
 && rm /tmp/jeff-hykin.better-cpp-syntax-1.15.10.vsix \
 && code-server --install-extension TabNine.tabnine-vscode # GitHub.copilot
