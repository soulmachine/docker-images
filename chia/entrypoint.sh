cd /chia-blockchain

. ./activate

chia init

chia keys add -f /mnemonic.txt

sed -i 's/localhost/127.0.0.1/g' ~/.chia/mainnet/config/config.yaml

chia plots create -n ${NUM_PLOTS} -t /tmp_dir -d /final_dir
