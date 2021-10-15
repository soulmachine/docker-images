FROM soulmachine/code-server:base

ARG LLVM_VERSION=14

RUN wget https://apt.llvm.org/llvm.sh \
 && chmod +x llvm.sh \
 && sudo ./llvm.sh $LLVM_VERSION \
 && rm ./llvm.sh \
 && sudo apt -qy update && sudo apt -qy --no-install-recommends install \
    clang-format-$LLVM_VERSION \
    clang-tidy-$LLVM_VERSION \
 && sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-$LLVM_VERSION 100 \
 && sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-$LLVM_VERSION 100 \
 && sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-$LLVM_VERSION 100 \
 && sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-$LLVM_VERSION 100 \
 && sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-$LLVM_VERSION 100 \
 && wget https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier \
 && chmod +x buildifier \
 && sudo mv buildifier /usr/local/bin \
 && sudo apt -qy autoremove && sudo apt clean && sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

COPY --chown=$USER:$USER ./.vscode/settings-cpp.json $XDG_DATA_HOME/code-server/User/settings.json

RUN code-server --install-extension llvm-vs-code-extensions.vscode-clangd \
 && code-server --install-extension xaver.clang-format \
 # && code-server --install-extension notskm.clang-tidy \
 && wget https://github.com/notskm/vscode-clang-tidy/releases/download/v0.5.1/clang-tidy-0.5.1.vsix \
 && code-server --install-extension clang-tidy-0.5.1.vsix \
 && rm clang-tidy-0.5.1.vsix \
 && code-server --install-extension vadimcn.vscode-lldb \
 && code-server --install-extension BazelBuild.vscode-bazel \
 && code-server --install-extension TabNine.tabnine-vscode # GitHub.copilot
