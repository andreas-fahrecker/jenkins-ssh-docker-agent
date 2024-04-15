FROM jenkins/ssh-agent:alpine

RUN addgroup --gid 281 docker
RUN addgroup jenkins docker

RUN apk add --no-cache docker docker-compose

# Install tea
RUN apk add --no-cache tea

# Install flutter
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing flutter 

RUN flutter config --no-cli-animations
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

#Install OpenSSL
RUN apk add --no-cache openssl

#Install Node.js
RUN apk add --no-cache nodejs npm