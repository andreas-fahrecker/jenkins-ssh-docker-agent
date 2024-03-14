FROM jenkins/ssh-agent:alpine

RUN addgroup --gid 281 docker
RUN addgroup jenkins docker

RUN apk add --no-cache docker docker-compose

# Install flutter
RUN apk add --no-cache flutter

RUN flutter config --no-cli-animations
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade
