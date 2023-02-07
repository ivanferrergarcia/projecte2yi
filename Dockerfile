#Dockerfile de l'apartat 3 del projecte2

FROM ubuntu:22.04

#Instal·lam tot el que demana l'enunciat:

RUN \ 
    apt update \
    && apt install -y ca-certificates openssh-client \
    wget curl iptables \
    supervisor \
    ssh \
    curl \
    python3 \
    python3-pip \
    nodejs \
    npm \
    mysql-client \
    git \
    maven \
    gradle \
    zip \  
    && apt upgrade -y && curl -s "https://get.sdkman.io" | bash \
    && apt install docker-compose -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash dev

#Copiam els fitxers startup.sh i modprobe dins un directori del dockerfile:
COPY startup.sh /bin/
COPY modprobe /bin/

#Carregam l'startup.sh i el modprobe:
RUN chmod +x /bin/startup.sh /bin/modprobe
VOLUME /var/lib/docker

#Exposam els ports:
EXPOSE 22
EXPOSE 8080

#Activam el supervisor
CMD ["/usr/bin/supervisord"]
