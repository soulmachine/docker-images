# vscode in container

This docker image is an out-of-the-box web-based vscode.

## How to use

### For C++ projects

First, generate a `compile_commands.json` file at the root directory of your C++ project.

Then open the root directory using this docker image,

```bash
# First, cd to the root directoty of your C++ project

# use Microsoft ms-vscode.cpptools
docker run -d --name code-server-cpp --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:cpp /project

# or use vscode-clangd
docker run -d --name code-server-clang --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:clang /project
```

And open <http://localhost:8080> in browser, password is `passw0rd`.

### For Rust projects

```bash
# First, cd to the root directoty of your Rust project
docker run -d --name code-server-rust --init -u "$(id -u):$(id -g)" -p 8081:8080 -v $(pwd):/project soulmachine/code-server:rust /project
```

And open <http://localhost:8081> in browser, password is `passw0rd`.

### For Python projects

```bash
# First, cd to the root directoty of your Python project
docker run -d --name code-server-python --init -u "$(id -u):$(id -g)" -p 8082:8080 -v $(pwd):/project soulmachine/code-server:python /project
```

And open <http://localhost:8081> in browser, password is `passw0rd`.

**If you're interested in what the container has done, continue reading.**

## Build

```bash
docker build -t soulmachine/code-server:base -f Dockerfile.base . --build-arg USERNAME=coder
docker push soulmachine/code-server:base

docker build -t soulmachine/code-server:cpp -f Dockerfile.cpp .
docker push soulmachine/code-server:cpp

docker build -t soulmachine/code-server:clang -f Dockerfile.clang . --build-arg LLVM_VERSION=14
docker push soulmachine/code-server:clang

docker build -t soulmachine/code-server:rust -f Dockerfile.rust .
docker push soulmachine/code-server:rust

docker build -t soulmachine/code-server:python -f Dockerfile.python .
docker push soulmachine/code-server:python
```

Each language should have the following 3 components:

1. The language server.
1. The linter.
1. The formatter.

Each component has a binary and a vscode extension.

## C++

There are two C++ language servers: [ms-vscode.cpptools](https://github.com/microsoft/vscode-cpptools) from Microsoft and [clangd](https://clangd.llvm.org/) from the llvm team.

If your project uses cmake or runs on Windows, go for ms-vscode.cpptools; if your project uses bazel, go for clangd.

### clangd

Use `clangd` as the language server and accordingly the [vscode-clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd) plugin as the IDE. Because `vscode-clangd` is more accurate than the official `ms-vscode.cpptools` plugin from Microsoft and uses less memory.

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

4. Disable `ms-vscode.cpptools`

   Make sure uninstall the `ms-vscode.cpptools` plugin and add the following configuratons to `settings.json`:

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

Use `clang-format` as the formatter to auto format code.

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

Use `clang-tidy` as the C++ linter.

1. Install `clang-tidy`

   ```bash
   # on Ubuntu
   sudo apt install clang-tidy-14
   sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-14 100
   # on macOS
   brew install llvm
   ```

2. Install the [notskm.clang-tidy](https://marketplace.visualstudio.com/items?itemName=notskm.clang-tidy) plugin

### ms-vscode.cpptools

Install the following extensions:

- [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [ms-vscode.cpptools-themes](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes)
- [twxs.cmake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)
- [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [cschlosser.doxdocgen](https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen)
- [jeff-hykin.better-cpp-syntax](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-cpp-syntax)

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

## Python

### Install the official Python extension

The [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) extension will automatically install the Pylance and Jupyter extensions.

- [ms-python.vscode-pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance) is the Python language server developed by Microsoft.
- [ms-toolsai.jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) provides support for Jupyter notebooks.

### pylint

Use `pylint` as the linter.

First, install pylint, `conda install pylint -c conda-forge` or `python3 -m pip install -U pylint`

Second, add the following configurations to vscode `settings.json`:

```json
"python.linting.pylintEnabled": true,
```

### yapf

Use `yapf` as the formatter.

First, install yapf, `conda install yapf -c conda-forge` or `python3 -m pip install -U yapf`

Second, add the following configurations to vscode `settings.json`:

```json
"python.formatting.provider": "yapf",
"python.formatting.yapfArgs": ["--style", "{based_on_style: google}"],
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
- <https://code.visualstudio.com/docs/python/editing>
- <https://code.visualstudio.com/docs/python/linting>
- <https://code.visualstudio.com/docs/languages/json>
- <https://github.com/cdr/code-server/blob/main/docs/FAQ.md>
- <https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack>
