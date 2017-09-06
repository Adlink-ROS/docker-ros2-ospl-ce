FROM ubuntu:16.04
MAINTAINER ChesterTseng "chester.tseng@adlinktech.com"
ENV OSPL_SOURCE=/root/opensplice
ENV GSOAP_MAJ_VER=2.8
ENV GSOAP_MIN_VER=51
ARG BRANCH=master
RUN apt-get update \
    && apt-get install -y gcc g++ make gawk bison flex perl git wget libssl-dev unzip \
    && git clone https://github.com/PrismTech/opensplice.git -b $BRANCH $OSPL_SOURCE

RUN wget https://downloads.sourceforge.net/project/gsoap2/gsoap-$GSOAP_MAJ_VER/gsoap_$GSOAP_MAJ_VER.$GSOAP_MIN_VER.zip -O /tmp/gsoap_$GSOAP_MAJ_VER.$GSOAP_MIN_VER.zip \
    && unzip /tmp/gsoap_$GSOAP_MAJ_VER.$GSOAP_MIN_VER.zip -d /opt \
    && rm /tmp/gsoap_$GSOAP_MAJ_VER.$GSOAP_MIN_VER.zip \
    && cd /opt/gsoap-$GSOAP_MAJ_VER \
    && ./configure --prefix=$PWD/usr \
    && make && make install

ENV GSOAPHOME=/opt/gsoap-$GSOAP_MAJ_VER/usr
ENV PATH=$PATH:/opt/gsoap-$GSOAP_MAJ_VER/usr/bin
ENV SPLICE_TARGET=x86_64.linux-release
ENV SPLICE_REAL_TARGET=x86_64.linux-release
ENV SPLICE_HOST=x86_64.linux-release

RUN cd $OSPL_SOURCE \
    && ln -s /opt/gsoap-$GSOAP_MAJ_VER/gsoap/stdsoap2.c /opt/gsoap-$GSOAP_MAJ_VER/usr/include/ \
    && /bin/bash -c "source configure $SPLICE_TARGET && make clean && make && make install"

VOLUME ["/root/opensplice"]
