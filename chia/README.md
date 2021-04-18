# Chia

This docker image can build Rust library and package it into a Python wheel.

## Build

```bash
docker build -t soulmachine/chia .
docker push soulmachine/chia
```

## How to use

```bash
docker run -d --name chia-plot -v /path/to/SSD:/tmp_dir -v /path/to/HDD:/final_dir -v /path/to/mnemonic.txt:/mnemonic.txt soulmachine/chia
```
