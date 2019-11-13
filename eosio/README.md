
# EOSIO

## Build docker images

```bash
docker build -t soulmachine/eosio.eos - < Dockerfile.eos

docker build -t soulmachine/eosio.cdt - < Dockerfile.cdt
```

## How to use

### As a normal user

Choose a public nodeos node and check Nodeos endpoints to make sure it is running:

```bash
curl https://mainnet.meet.one/v1/chain/get_info
```

Start the keosd container:

```bash
docker run -it --rm --name keosd -v $(pwd):/keosd/eosio-wallet soulmachine/eosio.eos keosd --wallet-dir /keosd/eosio-wallet --http-server-address=127.0.0.1:8900 --http-alias=localhost:8900
```

Add a `cleos` alias in bash profile:

```bash
alias cleos='docker exec -it keosd cleos -u https://mainnet.meet.one --wallet-url http://localhost:8900'
# alias cleos='docker run -it --rm soulmachine/eosio.eos cleos -u https://mainnet.meet.one --wallet-url http://localhost:8900'
```

Run `cleos get info` and you'll see the output:

```json
"chain_id": "aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906"
```

The `chain_id` above is exactly the `chain_id` of the EOS mainnet, which will never change.

Run `cleos wallet list` to make sure `keosd` is running.

### As a developer

Need to start both nodeos and keosd containers:

```bash
docker-compose up -d
```

After `docker-compose up -d`, two services named `nodeos` and `keosd` will be started. `nodeos` service would expose ports 8888 and 9876 to the host. `keosd` service does not expose any port to the host, it is only accessible to cleos when running cleos is running inside the keosd container as described in "Execute cleos commands" section.

Make sure `nodeos` is running:

```bash
curl http://localhost:8888/v1/chain/get_info
```

Make sure `keosd` is running:

```bash
curl http://localhost:8900/v1/wallet/list_wallets
```

Add a `cleos_dev` alias in bash profile:

```bash
alias cleos_dev='docker exec -it keosd cleos -u http://nodeos:8888 --wallet-url http://localhost:8900'
# alias cleos_dev='docker run -it --rm soulmachine/eosio.eos cleos -u http://localhost:8888 --wallet-url http://localhost:8900'
```

Note that we set nodeos URL to `http://nodeos:8888`, which is defined in `docker-compose.yml`, do NOT use `localhost` as nodeos address.

Run `cleos_dev wallet list` you'll see the same result as previous command `curl http://localhost:8888/v1/chain/get_info`.

Run `cleos_dev get info` and make sure the `chain_id` is the same as previous command `curl http://localhost:8888/v1/chain/get_info`.

### Creating and Managing Wallets

Create a default wallet,

```bash
cleos wallet create --to-console
```

Create a wallet named `periwinkle`,

```bash
cleos wallet create -n periwinkle --to-console
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
cleos wallet import --private-key PRIVATE_KEY_1
cleos wallet import --private-key PRIVATE_KEY_2
```

### Creating an Account

According to this Github issue, [Error 3090003](https://github.com/EOSIO/eos/issues/4154), we need to import the private key of the account `eosio` into default wallet,

```bash
cleos wallet import --private-key  5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
```

Create a new account,

```bash
cleos create account eosio soulmachine EOS6tXvJcfJDbMDCYy2vKLJ4kgADhfrYhidBAwBHm5GzUUNPmBoXN EOS6h7EJS3fsht67YrT44nNZ4SN7TWSAFToK7v1yuLA5oWRfpVTHL
```

Upload sample exchange contract

```bash
cleos set contract exchange contracts/exchange/
```

If you don't need keosd afterwards, you can stop the keosd service using

```bash
docker-compose stop keosd
```

## References

- [EOS API Endpoints](https://www.eosdocs.io/resources/apiendpoints/)
- [EOS Network Monitor.io](https://eosnetworkmonitor.io/)
