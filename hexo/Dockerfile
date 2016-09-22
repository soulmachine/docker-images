FROM mhart/alpine-node:latest
MAINTAINER soulmachine <soulmachine@gmail.com>


RUN npm install hexo-cli -g \
 && npm install hexo-generator-feed -g \
 && npm install hexo-deployer-git -g


ENTRYPOINT ["/usr/bin/hexo"]
