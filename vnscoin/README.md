This docker image wraps vnsRelease as a single executable.

**This docer image is public available at <https://hub.docker.com/r/soulmachine/vnscoin>**


## Build the image

    cd vnscoin
    docker build -t soulmachine/vnscoin .


## Sync blocks

    docker run -d --name vnscoin -v vnscoin:/root/.vnscoin soulmachine/vnscoin --fast --cache=1024 --maxpeers 10000


## Start miner

    docker run -d --name vnscoin -v vnscoin:/root/.vnscoin soulmachine/vnscoin --mine --vnsbase 2f42dc7e84a771ceefdb7e293e567ef3a8f9a17b


## Query balance

```bash
# Attach to the interactive console
docker exec -it vnscoin gvns attach

# query balance
vns.getBalance("0x2f42dc7e84a771ceefdb7e293e567ef3a8f9a17b")
```

## Send VNS to another address

```bash
# Copy your wallet file to this volume
docker cp 2f42dc7e84a771ceefdb7e293e567ef3a8f9a17b.json vnscoin:/root/.vnscoin/keystore/

# Attach to the interactive console
docker exec -it vnscoin gvns attach
```

```javascript
// Send coins to another address
var sender = "0x2f42dc7e84a771ceefdb7e293e567ef3a8f9a17b";
var receiver = "0xa6dc8628706cef8113ea4d5d231bbe89856cdf4b";
var coinsToSend = 200  // 200 VNS coins, CHANGE THIS
var transactionObject = {
  from: sender,
  to: receiver,
  value: coinsToSend * 1e+18 // multiplied by WEI
};

var estimatedGas= vns.estimateGas(transactionObject);
var valueToSend = totalBalance - estimatedGas * vns.gasPrice

var transactionObject = {
  from: sender,
  to: receiver,
  value: valueToSend,
  gas: estimatedGas
};

web3.personal.unlockAccount(sender, "PASSWORD")
vns.sendTransaction(transactionObject)
```
