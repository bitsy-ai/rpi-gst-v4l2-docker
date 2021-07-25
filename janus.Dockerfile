FROM debian:buster

# Platform dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libmicrohttpd-dev libjansson-dev \
	libssl-dev libsofia-sip-ua-dev libglib2.0-dev \
	libopus-dev libogg-dev libcurl4-openssl-dev liblua5.3-dev \
	libconfig-dev pkg-config gengetopt libtool automake \
    build-essential \
    git \
    python3-pip \
    cmake \
    wget

RUN mkdir /workspace
WORKDIR /workspace
RUN python3 -m pip install meson ninja
RUN git clone https://gitlab.freedesktop.org/libnice/libnice
RUN cd libnice && meson --prefix=/usr build && ninja -C build && ninja -C build install

RUN git clone https://github.com/sctplab/usrsctp
RUN cd usrsctp && \
    ./bootstrap && \
    ./configure --prefix=/usr --disable-programs --disable-inet --disable-inet6 && \
    make && make install

RUN git clone https://libwebsockets.org/repo/libwebsockets
RUN cd libwebsockets && git checkout v3.2-stable && \
    mkdir build && \
    cd build && \
    cmake -DLWS_MAX_SMP=1 -DLWS_WITHOUT_EXTENSIONS=0 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. && \
    make && make install

RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz
RUN tar xfv v2.2.0.tar.gz
RUN cd libsrtp-2.2.0 && \
    ./configure --prefix=/usr --enable-openssl && \
    make shared_library && make install

RUN git clone https://github.com/meetecho/janus-gateway.git
RUN cd janus-gateway && \
    sh autogen.sh && \
    ./configure --prefix=/opt/janus && \
    make && \
    make install

ENTRYPOINT [ "janus" ]