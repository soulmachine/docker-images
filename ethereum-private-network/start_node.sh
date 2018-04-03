#!/bin/sh
NODE=$1
ROLE=$2
datadir="/root/.ethereum"
if [ ! -d "$datadir/geth" ]; then
  geth --datadir $datadir init /ethconf/genesis.json
  cp /ethconf/f6de496ec5601d74937ddd77af09c8cd4ba41ab5.json /root/.ethereum/keystore
fi

if [[ $ROLE == "bootnode" ]]; then  # A normal full node without mining, acts as a bootnode
  JS="'enode://' + admin.nodeInfo.id + '@' + '$(hostname -i):' + admin.nodeInfo.ports.discovery"
  BOOTNODE_URL=$(geth --exec "${JS}" console 2>/dev/null | sed -e 's/^"\(.*\)"$/\1/')
  echo $BOOTNODE_URL > /ethconf/bootnode.txt
  geth --identity "$NODE" --rpc --rpcaddr "0.0.0.0" --rpcport "8545" --rpccorsdomain "*" --datadir $datadir --port "30303" --rpcapi "db,eth,net,web3,personal" --networkid 1999
else
  while [ ! -f /ethconf/bootnode.txt ]
  do
    echo "/ethconf/bootnode.txt not exists, wait for 3 seconds ..."
    sleep 3
  done
  bootnode_url=$(head -n 1 /ethconf/bootnode.txt)
  if [[ $ROLE == "miner" ]]; then  # A full node runs in mining mode
    geth --identity "$NODE" --bootnodes $bootnode_url --rpc --rpcaddr "0.0.0.0" --rpcport "8545" --rpccorsdomain "*" --datadir $datadir --port "30303" --rpcapi "db,eth,net,web3,personal" --networkid 1999 --preload /ethconf/start_miner.js
  else # A normal full node without mining by default
    geth --identity "$NODE" --bootnodes $bootnode_url --rpc --rpcaddr "0.0.0.0" --rpcport "8545" --rpccorsdomain "*" --datadir $datadir --port "30303" --rpcapi "db,eth,net,web3,personal" --networkid 1999
  fi
fi
