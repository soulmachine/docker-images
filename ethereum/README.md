This image has the official `geth` client installed, thus it can be used as a wallet.


## Run a full Ethereum node

    mkdir ethereum
    docker run -d --name ethereum -v $(pwd)/ethereum:/root/.ethereum -P soulmachine/ethereum geth --fast --cache 512


## List all accounts

    docker exec -it ethereum geth account list


## Create a new account

    docker exec -it ethereum geth account new

You need to enter your password and do NOT forget your password.


## Backup your accounts

Accounts are stored inside the directory `~/.ethereum/keystore`, each account has a corresponding JSON file. Basically this JSON file contains a public address and an encrypted private key.

To backup your accounts, just copy these JSON files to Dropbox, Google Drive, OneDrive, etc. Besides, make sure you also backup your passwords, because every account has a password.


## Import your accounts

Simply copy the JSON file back to the keystore directory, `~/.ethereum/keystore`.


## Query balance

Enter the Geth JavaScript console,

    docker exec -it ethereum geth attach

Then query balance,

    eth.getBalance(eth.coinbase)

You can also type other commands, such as `eth.accounts` and `eth.coinbase`.


## Send ETH

    web3.personal.unlockAccount(eth.coinbase, "PASSPHASE")
    eth.sendTransaction({from:eth.coinbase, to:"0xADDRESS", value: web3.toWei(AMOUNT, "ether")-30000*web3.eth.gasPrice, gas:30000})


## Get help

    docker run -it --rm soulmachine/ethereum geth help


## References

* <https://www.ethereum.org/cli>
* [Running in Docker](https://github.com/ethereum/go-ethereum/wiki/Running-in-Docker)
* [Ethereum Go](https://hub.docker.com/r/ethereum/client-go/)
* [Managing your accounts](https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts)
* [Chapter 2: Working With Contract Wallets](https://klmoney.wordpress.com/beta7-contract-wallets/)
* [Backup & restore](https://github.com/ethereum/go-ethereum/wiki/Backup-&-restore)