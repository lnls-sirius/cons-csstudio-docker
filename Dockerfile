# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory
FROM ubuntu:18.04

LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"
WORKDIR /opt/

RUN apt-get update
RUN apt-get install -y          \
    build-essential             \
    vim                         \
    openjdk-8-jre               \
    openjfx                     \
    libreadline-gplv2-dev       

RUN mkdir -p /opt/epics-R3.15.5
WORKDIR /opt/epics-R3.15.5

COPY base-3.15.5.tar.gz                 .

ENV PATH /opt/epics-R3.15.5/base/bin/linux-x86_64:$PATH
ENV EPICS_BASE /opt/epics-R3.15.5/base
ENV EPICS_HOST_ARCH linux-x86_64
ENV EPICS_CA_AUTO_ADDR_LIST YES

# Epics Base
RUN cd /opt/epics-R3.15.5           &&\
    tar -xvzf base-3.15.5.tar.gz    &&\
    rm base-3.15.5.tar.gz           &&\
    mv base-3.15.5 base             &&\
    cd base                         &&\
    make

COPY ttf-mscorefonts-installer_3.6_all.deb .
RUN apt-get -y install cabextract wget xfonts-utils
RUN  dpkg -i ttf-mscorefonts-installer_3.6_all.deb

# CS-Studio
WORKDIR /opt
COPY cs-studio-ess.tar.gz .
RUN tar -zxvf cs-studio-ess.tar.gz  &&\
    rm cs-studio-ess.tar.gz         &&\
    ln -s /opt/cs-studio/ESS\ CS-Studio /usr/bin/cs-studio
RUN apt clean                       &&\
    apt autoremove
CMD /usr/bin/cs-studio
