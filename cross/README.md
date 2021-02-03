# manylinux container to build Python wheels

This folder contains images forked from [rust-embedded/cross](https://github.com/rust-embedded/cross).

## Build

```bash
docker build -t soulmachine/cross:x86_64-unknown-linux-gnu -f Dockerfile.x86_64-unknown-linux-gnu .
docker push soulmachine/cross:x86_64-unknown-linux-gnu
```

## How to use

In Cross.toml:

```toml
[target.x86_64-unknown-linux-gnu]
image = "soulmachine/cross:x86_64-unknown-linux-gnu"
```
