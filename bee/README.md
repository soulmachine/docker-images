This docker compose file launches one clef node, one full node and multiple bee nodes.


## Quick Start

First, change everything in the `.env` to yours.

Then, run `docker compose up` to launch all nodes.

## How to add more bee nodes

Copy the `bee-2` section in `docker-compose.yaml`, then change the name to `bee-3`, and  adjust the `API_ADDR` and `P2P_ADDR` and `DEBUG_API_ADDR` to respectively 1833, 1834 and 127.0.0.1:1835. Lastly, add your newly configured services under volumes (last lines), such that it looks like:

```
volumes:
  ethereum:
  clef:
  bee-1:
  bee-2:
  bee-3:
```

## Backup clef volume

DO backup the data volume of clef!!!

First use `docker volume ls` to find the volume, then backup it following [the Docker official doc](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes).
