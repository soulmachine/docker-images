# code-server-bsc

A web-based vscode to develop BSC smart contracts.

## How to use

```bash
cd /path/to/your/project
docker run -d --name code-server-bsc --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:bsc code-server
```

The command above mounts your local source code to `/project` in the container, and open `/project` in vscode.

Use `docker logs -f code-server` to monitor the container, it will print the URL(default <http://localhost:8080>) and the password(default `passw0rd`) after a few seconds.

Open the URL in browser and enjoy!

## Build

```bash
docker build -t soulmachine/code-server:bsc .
docker push soulmachine/code-server:bsc
```
