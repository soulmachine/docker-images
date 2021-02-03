# Manylinux container to build Rust library to Python wheel

This docker image can build Rust library and package it into a Python wheel.

## Build

```bash
docker build -t soulmachine/rust:manylinux2014 -f Dockerfile.manylinux2014 .
docker push soulmachine/rust:manylinux2014
```

## How to use

```bash
# cd to your Rust project, e.g., crypto-crawler-py
docker run -it --rm -v $(pwd):/project soulmachine/rust:manylinux2014 bash
```
