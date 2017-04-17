Simpe TOR container as a Socks&HTTP Proxy


## Run

    docker run -d --name tor -p 9050:9050 -p 8118:8118 soulmachine/tor


## Connect to the SOCKS Proxy

Configure your browser/client to use the SOCKS proxy server at at `127.0.0.1:9050`


## Connect to the HTTP Proxy

Configure your browser/client to use the HTTP proxy server at at `127.0.0.1:8118`


## References

* [jgamblin/tor](https://github.com/jgamblin/tor)
* [np1/docker-tor-clientonly](https://github.com/np1/docker-tor-clientonly)
* [sledigabel/docker-tor-privoxy](https://github.com/sledigabel/docker-tor-privoxy)
