# code-server-go

A web-based vscode for Golang.

## How to use

```bash
cd /path/to/your/project
docker run -d --name code-server-go --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:go code-server
docker logs -f code-server-go
# go to http://localhost:8080>
```

The command above mounts your local source code to `/project` in the container, and open `/project` in vscode.

Use `docker logs -f code-server` to monitor the container, it will print the URL(default <http://localhost:8080>) and the password(default `passw0rd`) after a few seconds.

Open the URL in browser and enjoy!

## Build

```bash
docker build -t soulmachine/code-server:go .
docker push soulmachine/code-server:go
```
