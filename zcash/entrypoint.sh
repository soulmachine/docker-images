#!/bin/bash
# Generate a random password every time the container boots
grep -q -F "rpcpassword=" /root/.zcash/zcash.conf || echo "rpcpassword=$(head -c 32 /dev/urandom | base64)" >> /root/.zcash/zcash.conf
exec "$@"

