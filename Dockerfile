#
# Dockerfile
#

FROM debian:trixie

WORKDIR /root

RUN apt-get update

RUN apt-get install -y clang libbfd-dev uthash-dev libelf-dev libcapstone-dev  libreadline-dev libiberty-dev libgsl-dev build-essential git debootstrap file nano xxd

# Build wcc & install it
RUN git clone https://github.com/endrazine/wcc.git && cd wcc && git submodule init && git submodule update && make -i && make install

# Build openssl 
#RUN git clone https://github.com/openssl/openssl.git || echo ok
#RUN cd openssl && git checkout openssl-3.0.6
#RUN cd openssl && mkdir -p build-3.0.6
#RUN cd openssl/build-3.0.6 && ../Configure && make
#
#RUN cd openssl && git checkout openssl-3.0.7
#RUN cd openssl && mkdir -p build-3.0.7
#RUN cd openssl/build-3.0.7 && ../Configure && make
#
#RUN cd openssl && git checkout openssl-3.0.8
#RUN cd openssl && mkdir -p build-3.0.8
#RUN cd openssl/build-3.0.8 && ../Configure && make

RUN apt-get install -y libbpf1 libdbus-1-3 libdevmapper1.02.1 libestr0 libglib2.0-0 libglib2.0-dev libkmod2 libmnl0 libnewt0.52 libpopt0 sudo libxtables12 libfastjson-dev

# Prepare wcc tests
RUN git clone https://github.com/endrazine/wcc-tests.git && cd wcc-tests && make

WORKDIR /root
RUN apt-get install -y apache2
COPY apache_relink.tgz /root/apache_relink.tgz
RUN tar -xvzf apache_relink.tgz
RUN cd apache_relink && make

WORKDIR /root/wcc-tests


