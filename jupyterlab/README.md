# JupyterLab

JupyterLab Container for Data Science.

## Build

```bash
docker build -t soulmachine/jupyterlab:anaconda3 -f Dockerfile.anaconda3 .
docker build -t soulmachine/jupyterlab:miniconda3 -f Dockerfile.miniconda3 .

docker push soulmachine/jupyterlab:anaconda3
docker push soulmachine/jupyterlab:miniconda3
```

## Run

```bash
docker run -it --rm -v $(pwd):/notebooks -p 8080:8080 soulmachine/jupyterlab:anaconda3
```
