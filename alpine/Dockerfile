FROM jenkins/ssh-agent:alpine-jdk21

RUN addgroup --gid 281 docker
RUN addgroup jenkins docker

RUN apk add --no-cache docker docker-compose

# Install tea
RUN apk add --no-cache tea

# Install flutter
RUN apk --no-cache add bash curl git ca-certificates wget unzip 
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
RUN git config --global --add safe.directory /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN chown -R jenkins:jenkins /usr/local/flutter
# Run flutter doctor and upgrade
USER jenkins

RUN flutter config --no-cli-animations
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

RUN dart pub global activate flutter_distributor
RUN echo 'export PATH="$PATH:`dart pub global path`"' >> /etc/profile

USER root

#Install OpenSSL
RUN apk add --no-cache openssl

#Install git lfs
RUN apk add --no-cache git-lfs
RUN git lfs install --system