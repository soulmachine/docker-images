# Ethereum Private Network

Launch a private Ethereum network with docker compose

## Start the private network

    docker-compose up


## Play in geth console

First, attach to any running container,

    docker exec -it bootnode /bin/sh

Then attach to geth console,

    geth attach

Now you can write JavaScript code in the geth console.

### Unlock the account

There is already an account builtin in this private network on every node, the address is "0xf6de496ec5601d74937ddd77af09c8cd4ba41ab5" and the passphrase of its wallet file is `password`. So you can unlock it using the following command:

    web3.personal.unlockAccount("0xf6de496ec5601d74937ddd77af09c8cd4ba41ab5", "password")


### Check your balance

    web3.fromWei(eth.getBalance(eth.coinbase), "ether")


## References

* [Setting up a local private testnet geth (Go client)](http://www.ethdocs.org/en/latest/network/test-networks.html#id3)
* [params/config.go](https://github.com/ethereum/go-ethereum/blob/master/params/config.go)
* [Common useful JavaScript snippets for geth](https://ethereum.stackexchange.com/questions/2531/common-useful-javascript-snippets-for-geth)
