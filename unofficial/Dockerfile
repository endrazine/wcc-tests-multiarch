#
# Dockerfile
#

FROM polyarch/debian-ports:latest

WORKDIR /root

# Clean and update package lists
RUN apt-get clean && apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends libbfd-dev uthash-dev libelf-dev libcapstone-dev  libreadline-dev libiberty-dev libgsl-dev build-essential git debootstrap file nano xxd ca-certificates

# Build wcc & install it
RUN git clone https://github.com/endrazine/wcc.git && cd wcc && git checkout 5e7755d32906454f43dace8dcf850b70c4d7eaae && git submodule init && git submodule update && make -i && make install

RUN apt-get install -y libbpf1 libdbus-1-3 libdevmapper1.02.1 libestr0 libglib2.0-dev libkmod2 libmnl0 libnewt0.52 libpopt0 sudo libxtables12 libfastjson-dev

# Prepare wcc tests
RUN git clone https://github.com/endrazine/wcc-tests.git && cd wcc-tests && make -i

WORKDIR /root
RUN apt-get install -y apache2 nginx openssh-server
COPY apache_relink.tgz /root/apache_relink.tgz
RUN tar -xvzf apache_relink.tgz
RUN cd apache_relink && make -i

WORKDIR /root/wcc-tests


