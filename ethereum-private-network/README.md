# Ethereum Private Network

Launch a private Ethereum network with docker compose

## Start the private network

    docker-compose up


## Add peers

First, attach to node `eth1`,

    docker exec -it eth1 /bin/sh

Second, take note of its IP address,

    ifconfig

Attach to geth console,

    geth attach

Run `> admin.nodeInfo.enode` command to get this node's URL,

    enode://c743e5aba2ffc806456916a0314ed9430913e63e5c529889d6b6d20f5707019e519096e720f6d377c0a9d8d63d5e08818f1a1e4202075a70f4671b483dc2d4d3@[::]:30303

Replace `[::]` with the real IP address, then it becomes a complete URL:

    enode://c743e5aba2ffc806456916a0314ed9430913e63e5c529889d6b6d20f5707019e519096e720f6d377c0a9d8d63d5e08818f1a1e4202075a70f4671b483dc2d4d3@172.20.0.2:30303


Attach to another container and run`admin.addPeer("enode://c743e5aba2ffc806456916a0314ed9430913e63e5c529889d6b6d20f5707019e519096e720f6d377c0a9d8d63d5e08818f1a1e4202075a70f4671b483dc2d4d3@172.20.0.2:30303")` to add a peer.

Run `admin.peers` in both nodes and you will see they know each other now!
