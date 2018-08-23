## Get chain info

```bash
curl http://127.0.0.1:8888/v1/chain/get_info
```


## Start both nodeos and keosd containers

```bash
docker volume create --name=nodeos-data-volume
docker volume create --name=keosd-data-volume
docker-compose up -d
```

After `docker-compose up -d`, two services named `nodeosd` and `keosd` will be started. nodeos service would expose ports 8888 and 9876 to the host. keosd service does not expose any port to the host, it is only accessible to cleos when running cleos is running inside the keosd container as described in "Execute cleos commands" section.


### Execute cleos commands

You can run the `cleos` commands via a bash alias.

```bash
$ alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'
$ cleos get info
$ cleos get account inita
```


### Creating and Managing Wallets

Create a default wallet,

```bash
$ cleos wallet create --to-console
```

Create a wallet named `periwinkle`,

```bash
$ cleos wallet create -n periwinkle --to-console
```

List all wallets,

```bash
$ cleos wallet list
Wallets:
[
  "default *",
  "periwinkle *"
]
```


### Generating and Importing EOSIO Keys

Generate two public/private key pairs.

```bash
$ cleos create key --to-console
Private key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Public key: EOSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$ cleos create key --to-console
Private key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Public key: EOSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

Import the private keys into the default wallet,

```bash
$ cleos wallet import --private-key PRIVATE_KEY_1
$ cleos wallet import --private-key PRIVATE_KEY_2
```


### Creating an Account

According to this Github issue, [Error 3090003](https://github.com/EOSIO/eos/issues/4154), we need to import the private key of the account `eosio` into default wallet,

```bash
$ cleos wallet import --private-key  5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
```

Create a new account,

```bash
$ cleos create account eosio soulmachine EOS6tXvJcfJDbMDCYy2vKLJ4kgADhfrYhidBAwBHm5GzUUNPmBoXN EOS6h7EJS3fsht67YrT44nNZ4SN7TWSAFToK7v1yuLA5oWRfpVTHL
```

Upload sample exchange contract

```bash
cleos set contract exchange contracts/exchange/
```

If you don't need keosd afterwards, you can stop the keosd service using

```bash
docker-compose stop keosd
```
