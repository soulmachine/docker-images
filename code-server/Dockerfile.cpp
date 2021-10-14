FROM soulmachine/code-server:base

ARG USERNAME=werider

RUN printf "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-12 main" | sudo tee /etc/apt/sources.list.d/llvm-toolchain-xenial-12.list \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - \
 && sudo apt-get -qy update && sudo apt-get -qy --no-install-recommends install \
    clangd-12 \
    clang-format-12 \
    lldb-12 \
 && sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100 \
 && sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100 \
 && sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-12 100 \
 && wget https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier \
 && chmod +x buildifier \
 && sudo mv buildifier /usr/local/bin \
 && sudo apt-get -qy autoremove && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

COPY --chown=$USERNAME:$USERNAME ./.vscode/settings-cpp.json /home/$USERNAME/.local/share/code-server/User/settings.json
RUN code-server --install-extension llvm-vs-code-extensions.vscode-clangd \
 && code-server --install-extension xaver.clang-format \
 && code-server --install-extension vadimcn.vscode-lldb \
 && code-server --install-extension BazelBuild.vscode-bazel
