#!/bin/sh
set -eu

echo "Starting container, please wait...(chown inside docker is slow)"

eval "$(fixuid -q)"

case "$1" in
    "code-server")
        shift
        echo "The default password is passw0rd, you can change the password by setting the \$PASSWORD environment variable"
        /usr/bin/code-server "$@"
    ;;
    *)
        exec "$@"
    ;;
esac
