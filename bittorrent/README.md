# Build github.com/anacrolix/torrent to get binaries


## Build

```bash
docker build -t soulmachine/bittorrent .
docker push soulmachine/bittorrent
```

## How to use

```bash
# Copy binaries out of the container
docker run -it --rm -v $(pwd):/project soulmachine/bittorrent bash
cp /usr/local/bin/* /project
```
