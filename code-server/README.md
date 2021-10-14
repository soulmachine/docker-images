# vscode in container

This docker image is an out-of-the-box web-based vscode.

## How to use

### For C++ projects

First, generate a `compile_commands.json` file at the root directory of your C++ project.

Then open the root directory using this docker image,

```bash
# First, cd to the root directoty of your C++ project
docker run -d --name code-server-cpp --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:cpp
```

And open <http://localhost:8080> in browser, password is `passw0rd`.

### For Rust projects

```bash
# First, cd to the root directoty of your Rust project
docker run -d --name code-server-rust --init -u "$(id -u):$(id -g)" -p 8081:8080 -v $(pwd):/project soulmachine/code-server:rust
```

And open <http://localhost:8081> in browser, password is `passw0rd`.

## Build

```bash
docker build -t soulmachine/code-server:base -f Dockerfile.base .
docker push soulmachine/code-server:base

docker build -t soulmachine/code-server:cpp -f Dockerfile.cpp .
docker push soulmachine/code-server:cpp

docker build -t soulmachine/code-server:rust -f Dockerfile.rust .
docker push soulmachine/code-server:rust
```

If you're interested in what the container has done, keep reading.

## C++

### clangd

I choose `clangd` as the language server and accordingly the [vscode-clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd) plugin as the IDE. Because `vscode-clangd` is more accurate than the official `vscode-cpptools` plugin from Microsoft and uses less memory.

1. Install the [vscode-clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)

2. Install `clangd`

   Although the `vscode-clangd` plugin can download `clangd` automatically, we'd better install it in advance. See <https://clangd.llvm.org/installation.html>.

   ```bash
   # on Ubuntu
   sudo apt install clang-14
   sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 100
   # on macOS
   brew install llvm
   export PATH="/usr/local/opt/llvm/bin:$PATH"
   ```

3. Configure `vscode-clangd`

   Add the following configurations to `settings.json`:

   ```json
   "clangd.arguments": ["-log=verbose", "-pretty", "--background-index", "--compile-commands-dir=."],
   ```

4. Disable `vscode-cpptools`

   Make sure uninstall the `vscode-cpptools` plugin and add the following configuratons to `settings.json`:

   ```json
   "C_Cpp.intelliSenseEngine": "Disabled",
   "C_Cpp.autocomplete": "Disabled",
   "C_Cpp.errorSquiggles": "Disabled",
   ```

5. `compile_commands.json`

   To make `clangd` understand your C++ project, you need to generate a `compile_commands.json` file for your C++ project.

   If your project builds with CMake, it can generate this file. You should enable it with:

   `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1`

   `compile_commands.json` will be written to your build directory.

### clang-format

To use clang-format to auto format code,

1. Install clang-format on your host machine,

   ```bash
   # on macOS
   brew install clang-format
   # on Ubuntu
   sudo apt install clang-format
   ```

2. Install the [clang-format plugin](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format)
3. Add the following confings to vscode `settings.json`:

   ```json
   "[python]": {
    "editor.defaultFormatter": null
   },
   "[cpp]": {
    "editor.defaultFormatter": "xaver.clang-format"
   },
   "[c]": {
    "editor.defaultFormatter": "xaver.clang-format"
   },
   "[proto]": {
    "editor.defaultFormatter": "xaver.clang-format"
   },
   "clang-format.fallbackStyle": "Google",
   "clang-format.style": "file",
   ```

### lldb

I prefer `lldb` over `gdb` for debugging because `lldb` is more accurate, and most of time my C++ code runs on Linux only, Windows is irrelevant.

1. Install `lldb`

   ```bash
   # on Ubuntu
   sudo apt install lldb-14
   sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-14 100
   # on macOS
   brew install llvm
   export PATH="/usr/local/opt/llvm/bin:$PATH"
   ```

2. Install the [vscode-lldb](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) plugin

### clang-tidy

Use clang-tidy as the c++ linter.

1. Install `clang-tidy`

   ```bash
   # on Ubuntu
   sudo apt install clang-tidy-14
   sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-14 100
   # on macOS
   brew install llvm
   ```

2. Install the [notskm.clang-tidy](https://marketplace.visualstudio.com/items?itemName=notskm.clang-tidy) plugin

### Bazel

### buildifier

1. Install `buildifier` on your host,

   ```bash
   # on macOS
   wget https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier-linux-amd64
   mv buildifier-linux-amd64 buildifier
   chmod +x buildifier
   mv buildifier /usr/local/bin
   # on Ubuntu
   wget https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier
   chmod +x buildifier
   sudo mv buildifier /usr/local/bin
   ```

2. Install the [vscode-bazel plugin](https://marketplace.visualstudio.com/items?itemName=BazelBuild.vscode-bazel)
3. Add the following confings to vscode `settings.json`:

   ```json
   "[bazel]": {
    "editor.defaultFormatter": "BazelBuild.vscode-bazel"
   },
   "bazel.buildifierFixOnFormat": true,
   ```

## Rust

### cargo

1. Install `cargo` on your host machine,

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
   rustup default nightly
   ```

2. Install the [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer) plugin
3. Install the [TabNine](https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode) plugin

## References

- <https://apt.llvm.org/>
- <https://apt.llvm.org/llvm.sh>
- <https://github.com/linuxserver/docker-code-server>