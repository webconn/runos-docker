FROM ubuntu:16.04

MAINTAINER Nikita webconn Maslov <webconn@lvk.cs.msu.su>

RUN apt-get update && \
    apt-get -y install build-essential cmake autoconf libtool \
    pkg-config libgoogle-glog-dev libpcap-dev git \
    libssl-dev qtbase5-dev libboost-graph-dev libboost-system-dev \
    libboost-thread-dev libboost-coroutine-dev libboost-context-dev \
    libgoogle-perftools-dev curl wget iproute2 mininet bash-completion \
    iputils-ping net-tools \
    nano vim iperf iperf3 tcpdump netcat sudo tmux

# install nodejs 8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get -y install nodejs && \
    npm install uglify-js -g

WORKDIR /root

RUN wget https://github.com/libevent/libevent/releases/download/release-2.1.5-beta/libevent-2.1.5-beta.tar.gz && \
    tar xvf libevent-2.1.5-beta.tar.gz && \
    cd libevent-2.1.5-beta && \
    ./configure && make && make install && ldconfig && \
    cd .. && rm -rf libevent-2.1.5-beta libevent-2.1.5-beta.tar.gz

# install openvswitch
RUN git clone https://github.com/openvswitch/ovs && \
    cd ovs && git checkout v2.8.1 && ./boot.sh && \
    ./configure && make -j4 && make install && \
    cd .. && rm -rf ./ovs

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /userdata

COPY bashrc.sh /etc/bashrc.sh
COPY entrypoint.sh /sbin/entrypoint.sh
COPY path.sh /etc/profile.d

ENTRYPOINT ["/sbin/entrypoint.sh"]
