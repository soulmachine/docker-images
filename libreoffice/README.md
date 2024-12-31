# Headless Libreoffice Docker Image

## Build

```bash
docker build -t soulmachine/headless-libreoffice .
```

## Run

Convert a `.doc` file to `.pdf`:

```bash
docker run -it --rm -v $(pwd):/documents -u $(id -u):$(id -g) soulmachine/headless-libreoffice libreoffice --headless --convert-to pdf /documents/filename.doc
```
