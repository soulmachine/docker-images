#!/bin/sh
set -eu

echo "Starting coder-server, please wait(chown inside docker is slow)"

eval "$(fixuid -q)"

echo "The default password is passw0rd, you can change the password by setting the \$PASSWORD environment variable"

/usr/bin/code-server "$@"