FROM jenkins/ssh-agent:latest-jdk21

RUN groupadd -g 281 docker
RUN usermod -aG docker jenkins

RUN apt-get update
RUN apt-get install -y\
        ca-certificates \
        curl \
        gnupg

RUN mkdir -m 0755 -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN apt-get install -y docker-ce-cli

# Install tea
RUN apt-get install -y git make golang
RUN git clone https://gitea.com/gitea/tea.git
RUN cd tea && make && make install

# Install flutter
RUN apt-get install -y\
      curl git wget \
      unzip libgconf-2-4 gdb \
      libstdc++6 libglu1-mesa fonts-droid-fallback \
      lib32stdc++6 python3 sed

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
RUN echo 'export PATH="$PATH:`dart pub global path`"' >> ~/.bashrc

USER root

#Install OpenSSL
RUN apt-get install -y openssl
