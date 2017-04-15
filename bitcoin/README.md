This image has the official Bitcoin Core client installed, thus it can be used as a wallet.

## Run a Bitcoin full node

    mkdir bitcoin
    docker run -d -v $(pwd)/bitcoin:/data/bitcoin --name bitcoin soulmachine/bitcoin bitcoind


## List all wallet addresses

    docker exec -it bitcoin bitcoin-cli listreceivedbyaddress 0 true

Or,

    docker exec -it bitcoin bitcoin-cli getaddressesbyaccount ""


## Generate a wallet address

    docker exec -it bitcoin bitcoin-cli getnewaddress


<!--
## Encrypt a wallet

    docker exec -it bitcoin bitcoin-cli encryptwallet YOUR_PASS_PHRASE

After you run `encryptwallet`, you need to restart `bitcoind`. 

    docker kill bitcoin
    docker start bitcoin

Note that the `encryptwallet` command will disappear in `bitcoin-cli help`'s result, instead you will get three new commands: `walletlock`, `walletpassphrase` and `walletpassphrasechange`.

Run `docker exec -it bitcoin bitcoin-cli getinfo` you will see something like `"unlocked_until" : 0`, which means the wallet is locked.

Unlock the wallet for 30 seconds,

    docker exec -it bitcoin bitcoin-cli walletpassphrase YOUR_PASS_PHRASE 30

Run `bitcoin-cli getinfo` you will see `unlocked_until` has an expiration timestamp now.
-->


## Backup wallet

    docker exec -it bitcoin bitcoin-cli dumpwallet /data/bitcoin/MyBitcoinWallet.txt

Import it,

    docker exec -it bitcoin bitcoin-cli importwallet /data/bitcoin/MyBitcoinWallet.txt

Inside `MyBitcoinWallet.txt` you will see many pairs of private keys and public keys, `reserve=1` means the address is allocated but not used yet, you can ignore these addresses.

Actually the most important thing is private key, as long as you have the private key, you can restore the public key, ie., the Bitcoin address.

<!--
## Import wallet

    docker exec -it bitcoin bitcoin-cli importwallet /data/bitcoin/MyBitcoinWallet.bak

If your wallet is encrypted, you need to unlock it before importing it,

    docker exec -it bitcoin bitcoin-cli walletpassphrase YOUR_PASS_PHRASE 30
-->


## Query balance

    docker exec -it bitcoin bitcoin-cli getbalance


For more commands please run `bitcoin-cli help`.


## Get help

    docker exec -it bitcoin bitcoind -help
    docker exec -it bitcoin bitcoin-cli help

## References

* [Running A Full Node](https://bitcoin.org/en/full-node#ubuntu-1610)
* [kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind)
* [Chapter 3. The Bitcoin Client - oreilly.com](http://chimera.labs.oreilly.com/books/1234000001802/ch03.html)
