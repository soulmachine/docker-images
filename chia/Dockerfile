FROM ubuntu:latest

# References:
# - <https://github.com/Chia-Network/chia-blockchain/wiki/INSTALL#ubuntudebian>
# - <https://github.com/Chia-Network/chia-docker/blob/main/Dockerfile>

RUN apt -qy update && apt -qy upgrade && apt -qy --no-install-recommends install \
    ca-certificates git lsb-release sudo \
 && git clone https://github.com/Chia-Network/chia-blockchain.git -b latest \
 && cd chia-blockchain && sh ./install.sh && . ./activate && chia init \
 && apt -qy autoremove && apt clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

WORKDIR /chia-blockchain
ADD ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
