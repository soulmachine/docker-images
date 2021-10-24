## Other Tools

These tools are not installed in the docker image, but they might be moved into the image in future.

### Build Tool

#### Bazel

1. Install bazel

   ```bash
   wget https://github.com/bazelbuild/bazel/releases/download/4.2.1/bazel-4.2.1-installer-linux-x86_64.sh \
   chmod +x bazel-4.2.1-installer-linux-x86_64.sh \
   sudo ./bazel-4.2.1-installer-linux-x86_64.sh
   ```

2. Install the [vscode-bazel plugin](https://marketplace.visualstudio.com/items?itemName=BazelBuild.vscode-bazel)

3. Install `buildifier` on your host,

   ```bash
   wget https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier
   chmod +x buildifier
   sudo mv buildifier /usr/local/bin
   ```

4. Add the following confings to vscode `settings.json`:

   ```json
   "[bazel]": {
    "editor.defaultFormatter": "BazelBuild.vscode-bazel"
   },
   "bazel.buildifierFixOnFormat": true,
   ```
