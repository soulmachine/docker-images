# vscode in container

This docker image is an out-of-the-box web-based vscode.

## How to use

Given a C++ project on local disk, you can open this project by running:

```bash
docker run -d --name code-server --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:cpp /project
```

The command above mounts your local source code to `/project` in the container, and open `/project` in vscode. You can change `/project` to whatever path your prefer.

Use `docker logs -f code-server` to monitor the container, it will print the URL(default <http://localhost:8080>) and the password(default `passw0rd`) after a few seconds.

Open the URL in browser and enjoy!

All available images:

| Language | Docker Image                   |
| -------- | ------------------------------ |
| C++      | soulmachine/code-server:cpp    |
| C++      | soulmachine/code-server:clang  |
| Python   | soulmachine/code-server:python |
| Rust     | soulmachine/code-server:rust   |
| Java     | soulmachine/code-server:java   |

**If you're interested in what the container has done, continue reading.**

## Build

```bash
docker build -t soulmachine/code-server:base -f Dockerfile.base . --build-arg USERNAME=coder
docker build -t soulmachine/code-server:cpp-base -f Dockerfile.cpp-base .

docker build -t soulmachine/code-server:cpp -f Dockerfile.cpp .
docker push soulmachine/code-server:cpp

docker build -t soulmachine/code-server:clang -f Dockerfile.clang .
docker push soulmachine/code-server:clang

docker build -t soulmachine/code-server:rust -f Dockerfile.rust .
docker push soulmachine/code-server:rust

docker build -t soulmachine/code-server:python -f Dockerfile.python .
docker push soulmachine/code-server:python

docker build -t soulmachine/code-server:java -f Dockerfile.java .
docker push soulmachine/code-server:java
```

Each language should have the following 3 components:

1. The language server.
1. The linter.
1. The formatter.

Each component has a binary and a vscode extension.

## C++

### 1. Language Server

There are two popular C++ language servers: [ms-vscode.cpptools](https://github.com/microsoft/vscode-cpptools) from Microsoft and [clangd](https://clangd.llvm.org/) from the LLVM team.

The `Dockerfile.clang` chooses `clangd` as the language server and `Dockerfile.cpp` chooses `ms-vscode.cpptools` as the language server.

If your project uses cmake or runs on Windows, go for ms-vscode.cpptools; if your project uses bazel, go for clangd.

### ms-vscode.cpptools

- [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)

### clangd

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

### 2. Linter

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

### 3. Formatter

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

### 4. Build Tool

#### CMake

CMake is a popular build tool similar to bazel.

First, `sudo apt install make cmake`

Second, install the [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools) extension and the - [twxs.cmake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake) extension.

### 5. Debugger

lldb is a debugger similar to gdb.

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

### 6. Other utility tools

- [ms-vscode.cpptools-themes](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes)
- [cschlosser.doxdocgen](https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen)
- [jeff-hykin.better-cpp-syntax](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-cpp-syntax)

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
- <https://code.visualstudio.com/docs/cpp/customize-default-settings-cpp>
- <https://github.com/microsoft/vscode-cpptools/blob/main/Extension/c_cpp_properties.schema.json>
- <https://github.com/microsoft/vscode/blob/main/src/vs/workbench/browser/workbench.contribution.ts>
- <https://code.visualstudio.com/docs/cpp/c-cpp-properties-schema-reference>
- <https://libcxx.llvm.org>
- [disable IntelliSense when vscode-clangd is detected #4979](https://github.com/microsoft/vscode-cpptools/issues/4979)
- [Allow building in different directories per build type #151](https://github.com/microsoft/vscode-cmake-tools/issues/151)
- [[feature request] support for vscode-clangd #654](https://github.com/microsoft/vscode-cmake-tools/issues/654)
- [Implement enhanced integration with clang-tidy #2908](https://github.com/microsoft/vscode-cpptools/issues/2908)
- [Increase fs.inotify.max_user_watches in docker container #628](https://github.com/cdr/code-server/issues/628)
- [CMake Kits](https://vector-of-bool.github.io/docs/vscode-cmake-tools/kits.html)
- [CMAKE_GENERATOR](https://cmake.org/cmake/help/latest/variable/CMAKE_GENERATOR.html)
- [cmake-presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html)
- [vscode-clangd configuration](https://github.com/clangd/vscode-clangd/blob/master/package.json#L87)
- [google-cloud-cpp/blob/main/.clang-tidy](https://github.com/googleapis/google-cloud-cpp/blob/main/.clang-tidy)
- [What’s the recommended way to setup vscode completion with mbed-tools?](https://forums.mbed.com/t/whats-the-recommended-way-to-setup-vscode-completion-with-mbed-tools/13295)
- [markdown preview is not working #4101](https://github.com/cdr/code-server/issues/4101)
- [Github Copilot Support? #4363](https://github.com/cdr/code-server/discussions/4363)
- [googletest/blob/master/.clang-format](https://github.com/google/googletest/blob/master/.clang-format)
- [google-cloud-cpp/blob/main/.clang-tidy](https://github.com/googleapis/google-cloud-cpp/blob/main/.clang-tidy)
- [Using VSCode with metals](https://docs.scala-lang.org/getting-started/index.html#using-vscode-with-metals)
- <https://projectlombok.org/setup/vscode>
- [vscode-maven-0.21.2: Cannot extract bundle symbolicName or version #2362](https://github.com/cdr/code-server/issues/2362)
