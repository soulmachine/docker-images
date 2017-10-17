#!/bin/bash
set -e

# Generate a random password every time the container boots
grep -q -F "rpcpassword=" /root/.namecoin/namecoin.conf || echo "rpcpassword=$(openssl rand -hex 30)" >> /root/.namecoin/namecoin.conf

if [ "$1" = 'namecoind' ]; then
    exec namecoind -datadir=/data/namecoin -conf=/root/.namecoin/namecoin.conf `echo ${@:2}`
else
    exec "$@"
fi

