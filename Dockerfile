FROM nvidia/cuda:8.0-devel-ubuntu16.04
WORKDIR /ethminer

ARG binary_file
ARG pool_url

RUN apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:ethereum/ethereum -y \
    && apt-get update \
    && apt-get install -y git \
     cmake \
     libleveldb-dev \
     libjsoncpp-dev \
     libjsonrpccpp-dev \
     libboost-all-dev \
     libgmp-dev \
     libreadline-dev \
     libcurl4-gnutls-dev \
     ocl-icd-libopencl1 \
     opencl-headers \
     mesa-common-dev \
     libmicrohttpd-dev \
     build-essential

ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

COPY ./${binary_file} /ethminer/${binary_file}
RUN tar xvf ${binary_file}

ENV pool_url=$pool_url

CMD /ethminer/bin/ethminer --cuda --pool ${pool_url}
