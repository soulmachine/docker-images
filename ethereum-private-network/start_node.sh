#!/bin/sh
NODE=$1
datadir="/root/.ethereum"
if [ ! -d "$datadir/geth" ]; then
  geth --datadir $datadir init /ethconf/genesis.json
fi
geth --identity "$NODE" --rpc --rpcport "8081" --rpccorsdomain "*" --datadir $datadir --port "30303" --rpcapi "db,eth,net,web3,personal" --networkid 1999
