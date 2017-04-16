This image has the official ZCash client installed, thus it can be used as a wallet.

## Run a ZCash node

    mkdir zcash
    docker run -d -v $(pwd)/zcash:/data/zcash --name zcash soulmachine/zcash zcashd -exportdir=/data/zcash

If you don't set the `-exportdir` option, when you run `dumpwallet`, `backupwallet` and `z_exportwallet`, you will get an error:

    Cannot export wallet until the zcashd -exportdir option has been set


## List all addresses

List all `t-addr` addresses,

    docker exec -it zcash zcash-cli listreceivedbyaddress 0 true

Or,

    docker exec -it zcash zcash-cli getaddressesbyaccount ""

List all `z-addr` addresses,

    docker exec -it zcash zcash-cli z_listaddresses

What's the differences between `t-addr` and `z-addr` ? See [What's the difference between `z-addr` and `t-addr` type addresses? - StackExchange](https://bitcoin.stackexchange.com/a/49420/48381)

**Similarities**: Both `t-addr` and `z-addr` can send and receive coins.

**Differences**: A `t-addr` address is veiry similar to a Bitcoin address, both `t-addr`s and Bitcoin addresses can be viewed publicly in the blockchain, while `z-addr`s can not be viewed publicly.  If you look at the [third transaction](https://explorer.zcha.in/transactions/10475a6a60bee70c8e95d24dbfce9626cf1633c7377c9111e1b275140e2cfb5d) in [block 3706](https://explorer.zcha.in/blocks/0000000483614b20aedc4806e41e1890e580cee401dcbc24bf118cebb8615c46), you can see the input addresses are `t-addr`s but the output is blank because the output address is a `z-addr`. If you want to be completely anonymous, use `z-addr`

**Relations**: No relations, `z-addr`s and `t-addr`s are completely independent. Given a `z-addr`you can't get its `t-addr`, and vice versa. But each `z-addr` has and only has one private key, same for `t-addr`.

When a new ZCash node starts, it will pre-generate a `t-addr`, that's why you can see a `t-addr` but no `z-addr` on a new ZCash node.

The code base of ZCash originates from Bitcoin core, so most of terms and concepts are very similar to Bitcoin.


## Generate a wallet address

Generate a `t-addr`,

    docker exec -it zcash zcash-cli getnewaddress

This will generate a `t-addr`, which is actually a public key in [Asymmetric Cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography),

* Each `t-addr` has a corresponding private key(`zcash-cli dumpprivkey <t-addr>`)
* You can restore your `t-addr` with the private key(`zcash-cli importprivkey <private-key>`), not vice versa
* As long as you have the private key, you control the funds.

Generate a `z-addr`,

    docker exec -it zcash zcash-cli z_getnewaddress

This will generate a `z-addr`, which is also a public key, but can not be viewed in the blockchain.

* Each `z-addr` has a corresponding private key(`zcash-cli dumpprivkey <t-addr>`)
* You can restore your `z-addr` with the private key(`zcash-cli importprivkey <private-key>`), not vice versa
* As long as you have the private key, you control the funds.


## Backup your wallet


### Method 1

Backup all your private keys, `t-addr`s and `z-addr`s to a text file,

    docker exec -it zcash zcash-cli dumpwallet MyZcashWallet

You can store this text file to anywhere you like, for example Dropbox, Google Drive, Microsoft OneDrive, Evernote, etc.

Import it,

    docker exec -it zcash zcash-cli importwallet /data/zcash/MyZcashWallet

There is another command `backupwallet` that is very similar to `dumpwallet`, the only difference is that `backupwallet` generates a binary file instead of a text file. Since binary files are not friendly to other tools such as Evernote, I rarely use `backupwallet`.


### Method2

To backup your wallet, actually the only important thing is your private key, as long as you have the private key, you can restore its corresponding `t-addr` or `z-addr` address.

Show your private key,

    # for t-addr
    docker exec -it zcash zcash-cli dumpprivkey t1P4fnXWE3XibaZEEt99y1K7A3qBhg2rVnw
    # for z-addr
    docker exec -it zcash zcash-cli z_exportkey zceUduGRiVpaBfkwprWPNyX1TyQpuFQsu9iNJ2SYqm1eSkvBUDHzEuWggukAiFVaknfH7nvG8twzxfi1uegpNaYe6bYkWFr

This will print your private key to screen,

* You can print your private to a paper via a printer and hide this paper in a secret place, this is so called [Paper Wallet](https://en.bitcoin.it/wiki/Paper_wallet)
* You can memorize this private key in your own brain and never tell it to other people, this is so called [Brain Wallet](https://en.bitcoin.it/wiki/Brainwallet)
* You can save this private key to Evernote, OneNote, etc.

Import a private key,

    # for t-addr
    docker exec -it zcash zcash-cli importprivkey YOUR_PRIVATE_KEY
    # for z-addr
    docker exec -it zcash zcash-cli z_importkey YOUR_PRIVATE_KEY

Usually I prefer the second method because it has better compatibility(compatible human brain, printers, Evernote, etc.).


### Method 3

Backup all your private keys, `t-addr`s and `z-addr`s to a text file,

    docker exec -it zcash zcash-cli z_exportwallet MyZCashWallet


Import a wallet,

    docker exec -it zcash zcash-cli z_importwallet /data/zcash/MyZCashWallet


## Query balance,

    docker exec -it zcash zcash-cli getbalance

For more commands please read [ZCash 1.0 User Guide](https://github.com/zcash/zcash/wiki/1.0-User-Guide)


## Get help

    docker exec -it zcash zcashd -help
    docker exec -it zcash zcash-cli help


## References

* <https://z.cash/download.html>
* [andyceo/docker-zcash](https://github.com/andyceo/docker-zcash)
* [kost/docker-zcash](https://github.com/kost/docker-zcash)
* [Is `z-addr` to `t-addr` a one-to-one or one-to-many mapping?](https://forum.z.cash/t/is-z-addr-to-t-addr-a-one-to-one-or-one-to-many-mapping/15249)
