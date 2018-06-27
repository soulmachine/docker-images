This docker image wraps vnsRelease as a single executable.


## Build the image

    cd vnscoin
    docker build -t soulmachine/vnscoin .


## Sync blocks

    docker run -d --name vnscoin -v vnscoin:/root/.vnscoin soulmachine/vnscoin --fast --cache=1024 --maxpeers 10000


## Start miner

    docker run -d --name vnscoin -v vnscoin:/root/.vnscoin soulmachine/vnscoin --mine --vnsbase d9fe419028e25adb407208719e0d0aaef92898d4


## Query balance

```bash
# Attach to the interactive console
docker exec -it vnscoin gvns attach

# query balance
vns.getBalance("0xd9fe419028e25adb407208719e0d0aaef92898d4")
```

## Send VNS to another address

```bash
# Copy your wallet file to this volume
docker cp d9fe419028e25adb407208719e0d0aaef92898d4.json vnscoin:/root/.vnscoin/keystore/

# Attach to the interactive console
docker exec -it vnscoin gvns attach


// Send the entire balance to another address
var sender = "0xd9fe419028e25adb407208719e0d0aaef92898d4";
var receiver = "0xa6dc8628706cef8113ea4d5d231bbe89856cdf4b";
var totalBalance = vns.getBalance(sender);
var transactionObject = {
  from: sender,
  to: receiver,
  value: totalBalance
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
