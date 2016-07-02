FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    locales \
    sudo \
    ca-certificates \
    openssh-client \
    git \
    build-essential \
    cmake \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
 && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN adduser --disabled-password --gecos '' docker \
 && adduser docker sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update && apt-get install -y \
    wget \
    bc \
    gawk \
    gperf \
    zip \
    unzip \
    texinfo \
    xfonts-utils \
    xsltproc \
    default-jre-headless \
    libncurses5-dev \
    libxml-parser-perl \
    u-boot-tools \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

USER docker
