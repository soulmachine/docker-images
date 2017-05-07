FROM mhart/alpine-node:latest
MAINTAINER soulmachine <soulmachine@gmail.com>


RUN npm install hexo-cli -g \
 && npm install hexo-deployer-git -g

EXPOSE 4000
ENTRYPOINT ["/usr/bin/hexo"]
