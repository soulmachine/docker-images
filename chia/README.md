# Chia

This docker image wraps `chia` as a single command.

## Start plotting

```bash
docker run -d --name chia-plotter -v /path/to/SSD:/tmp_dir -v /path/to/HDD:/final_dir soulmachine/chia:plotter chia plots create -f your_farmer_public_key -p your_pool_public_key -n 1 -t /tmp_dir -d /final_dir
```

Use `chia keys show` to get your farmer publick key and pool public key.

## Build

```bash
docker build -t soulmachine/chia:plotter .
docker push soulmachine/chia:plotter
```
