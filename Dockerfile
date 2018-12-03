# Author: Cuong Tran
#

FROM ubuntu:18.04
LABEL maintainer="cuongtransc@gmail.com"

ENV REFRESHED_AT 2018-12-04

RUN apt-get update -qq

# Using apt-cacher-ng proxy for caching deb package
# RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142/";' > /etc/apt/apt.conf.d/01proxy

# Make the "en_US.UTF-8" locale
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y byobu zsh vim git mosh htop less curl gnupg

RUN export CLOUD_SDK_REPO="cloud-sdk-bionic" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update && apt-get install -y google-cloud-sdk

# Install Kubernetes
COPY bin/* /usr/local/bin/

# Home
WORKDIR /root

# Config
COPY dotfiles/ /root
COPY tools /root/tools

RUN chsh -s /bin/zsh root

VOLUME ["/root"]

# Docker Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["start"]
