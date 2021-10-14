#!/bin/sh
set -eu

eval "$(fixuid -q)"

/usr/bin/code-server "$@"