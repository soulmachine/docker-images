# code-server-bsc

A web-based vscode to develop BSC smart contracts.

## How to use

```bash
cd /path/to/your/project
docker run -d --name code-server-bsc --init -u "$(id -u):$(id -g)" -p 8080:8080 -v $(pwd):/project soulmachine/code-server:bsc code-server
docker logs -f code-server
# go to http://localhost:8080>
```

The command above mounts your local source code to `/project` in the container, and open `/project` in vscode.

Use `docker logs -f code-server` to monitor the container, it will print the URL(default <http://localhost:8080>) and the password(default `passw0rd`) after a few seconds.

Open the URL in browser and enjoy!

## Build

```bash
docker build -t soulmachine/code-server:bsc .
docker push soulmachine/code-server:bsc
```

## References

* [Intro to Solidity Linting and Formatting](https://medium.com/coinmonks/introduction-to-solidity-linting-and-formatting-e838c074791a)
* [How to Setup Linters, Surya, and Test Your Code Coverage in Solidity](https://www.maxgrok.com/posts/how-to-setup-solidity-linters)
* <https://docs.binance.org/smart-chain/developer/deploy/truffle.html>
* <https://docs.soliditylang.org/en/latest/installing-solidity.html#linux-packages>
* [How to Setup Linters, Surya, and Test Your Code Coverage in Solidity](https://www.maxgrok.com/posts/how-to-setup-solidity-linters)
