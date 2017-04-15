This image has the official ZCash client installed, thus it can be used as a wallet.

## Run a ZCash node

    mkdir zcash
    docker run -d -v $(pwd)/zcash:/data/zcash --name zcash soulmachine/zcash zcashd


## Generate a wallet address

Generate a `z-addr`,

    docker exec -it zcash zcash-cli z_getnewaddress

This will generate a `z-addr` and its corresponding `t-addr`, both of them stand for the same wallet.

What's the differences between `t-addr` and `z-addr` ? See [What's the difference between `z-addr` and `t-addr` type addresses? - StackExchange](https://bitcoin.stackexchange.com/a/49420/48381)

In one word, both `t-addr` and `z-addr` can send and receive coins, but if you want to be completely anonymous, use `z-addr`.


## Backup wallets

Backup all your keys, for both `t-addr` and `z-addr`:

    docker exec -it zcash zcash-cli z_exportwallet MyZCashWallet

This would give an error:

    Cannot export wallet until the zcashd -exportdir option has been set

So we need to provide the `-exportdir` option,

    docker kill zcash
    docker run -d -v $(pwd)/zcash:/data/zcash --name zcash soulmachine/zcash zcashd -exportdir=/data/zcash

Then backup again,

    docker exec -it zcash zcash-cli z_exportwallet MyZCashWallet


## Import wallets

    docker exec -it zcash zcash-cli z_importwallet /data/zcash/MyZCashWallet


## Other useful commands

List all `t-addr`s,

    docker exec -it zcash zcash-cli listreceivedbyaddress 0 true

List all `z-addr`s,

    docker exec -it zcash zcash-cli z_listaddresses

Query balance,

    docker exec -it zcash zcash-cli getbalance

For more commands please read [ZCash 1.0 User Guide](https://github.com/zcash/zcash/wiki/1.0-User-Guide)


## Get help

    docker exec -it zcash zcashd -help
    docker exec -it zcash zcash-cli help

## References

* <https://z.cash/download.html>
* [andyceo/docker-zcash](https://github.com/andyceo/docker-zcash)
* [kost/docker-zcash](https://github.com/kost/docker-zcash)
