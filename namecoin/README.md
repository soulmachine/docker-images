This image has the official Namecoin client installed.

## Run a Namecoin node

    mkdir namecoin && cd namecoin
    docker run -d --name namecoin -v $(pwd):/data/namecoin soulmachine/namecoin namecoind
    // or
    docker run -it --rm --name namecoin -v $(pwd):/data/namecoin soulmachine/namecoin namecoind -printtoconsole


## Get help

    docker exec -it namecoin namecoind -?


## References

* [Download](https://namecoin.org/download/)
* [FAQ](https://namecoin.org/faq/)
* [Install and Configure Namecoin - Namecoin Wiki](https://wiki.namecoin.info/index.php?title=Install_and_Configure_Namecoin)
* [arturluizbr/docker-namecoin: A ready-to-go Namecoin image](https://github.com/arturluizbr/docker-namecoin)
