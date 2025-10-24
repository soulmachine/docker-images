# Simpe TOR container as a Socks&HTTP Proxy

## Run

```bash
docker run -d --name tor -p 9050:9050 -p 9051:9051 -p 8118:8118 soulmachine/tor
```

## Connect to the SOCKS Proxy

Validate the SOCKS proxy:

```bash
curl --socks5 127.0.0.1:9050 https://check.torproject.org/api/ip
{"IsTor":true,"IP":"45.64.186.122"}
```

If you see the above output, it means the SOCKS proxy is working.

Configure your browser/client to use the SOCKS proxy server at at `127.0.0.1:9050`



## Connect to the HTTP Proxy

Validate the HTTP proxy:

```bash
curl --proxy 127.0.0.1:8118 https://check.torproject.org/api/ip
{"IsTor":true,"IP":"54.39.50.28"}
curl --proxy 127.0.0.1:8118 https://checkip.amazonaws.com/
109.70.100.1
curl --proxy 127.0.0.1:8118  ifconfig.co/
109.70.100.1
```

If you see the above output, it means the HTTP proxy is working.

Configure your browser/client to use the HTTP proxy server at at `127.0.0.1:8118`


## Change IP Addresses Dynamically

TOR resets its IP adress every 10 minutes automatically. But when you're crawling a website and this website complains that you have submited too many requests, you need to change your IP address in this scenario. How to make TOR change its IP immediately ?

Basically you need to use [stem](https://stem.torproject.org/). First install stem,

```bash
sudo pip3 install stem
```

And change the IP address with the following code:

```python
from stem import Signal
from stem.control import Controller
import time

def change_ip():
    with Controller.from_port(port = 9051) as controller:
        controller.authenticate(password = 'tor123456')
        controller.signal(Signal.NEWNYM)
    time.sleep(5)  # wait for the tor node to change IP
```

Let's make an experiment,

```python
import requests

def show_my_ip(proxies):
    r = requests.get('http://checkip.dyndns.org', proxies=proxies)
    tmp = r.text
    pos1 = tmp.find('Current IP Address:')
    pos2 = tmp.find('</body></html>')
    ip = tmp[(pos1+len('Current IP Address: ')): pos2]
    print('Run request with IP: ' + ip)


socks_proxies = { 'http': 'socks5://localhost:9050', 'https': 'socks5://localhost:9050' }

show_my_ip(socks_proxies)
change_ip()
show_my_ip(socks_proxies)  # CHANGED
```

## Build

```bash
cd tor
docker build -t soulmachine/tor .
docker push soulmachine/tor
```

## References

- [jgamblin/tor](https://github.com/jgamblin/tor)
- [np1/docker-tor-clientonly](https://github.com/np1/docker-tor-clientonly)
- [sledigabel/docker-tor-privoxy](https://github.com/sledigabel/docker-tor-privoxy)
- [Setting up privoxy](https://help.ubuntu.com/community/Privoxy)
- [vdaubry/tor-privoxy](https://github.com/vdaubry/tor-privoxy)
- [mattes/rotating-proxy](https://github.com/mattes/rotating-proxy)
- [Crawling anonymously with Tor in Python](http://sacharya.com/crawling-anonymously-with-tor-in-python/)
- [Running Tor Proxy with Docker](https://dev.to/nabarun/running-tor-proxy-with-docker-56n9)
