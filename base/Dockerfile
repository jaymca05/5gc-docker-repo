#FROM ubuntu:22.04 AS base
FROM ubuntu:22.04 AS base

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      git \
      wget \
      libsctp-dev \
      libssl-dev \
      libnghttp2-dev \
      libmongoc-dev \
      libbson-dev \
      pkg-config \
      ca-certificates \
      curl \
      python3-pip \
      python3-setuptools \
      python3-wheel \
      ninja-build \
      flex \
      bison \
      libgnutls28-dev \
      libgcrypt-dev \
      libyaml-dev \
      libmicrohttpd-dev \
      libcurl4-gnutls-dev \
      libtins-dev \
      libtalloc-dev \
      meson \
      libidn-dev \
      libnghttp2-dev \
      libsctp-dev \
      libtalloc2 \
      libmicrohttpd12 \
      libcurl4-gnutls-dev \
      libyaml-0-2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Clone Open5GS at tag v2.7.6
RUN git clone --branch v2.7.6 https://github.com/open5gs/open5gs.git

WORKDIR /opt/open5gs
#RUN ./autogen.sh && ./configure && make -j$(nproc)
RUN meson build --prefix=`pwd`/install && \
    ninja -C build && \
    ninja -C build install
RUN echo "/opt/open5gs/install/lib" > /etc/ld.so.conf.d/open5gs.conf && ldconfig
# Keep the source + built artifacts
# Expose necessary ports (adjust as needed)

WORKDIR /open5gs
# Create runtime directories
RUN mkdir -p /open5gs 

# Runtime stage
#FROM ubuntu:22.04

#COPY --from=builder /opt/open5gs/install/bin /open5gs
#COPY --from=builder /opt/open5gs/install/etc/open5gs /etc/open5gs
#COPY --from=builder /etc/open5gs /etc/open5gs
#COPY --from=builder /var/log/open5gs /var/log/open5gs
#COPY --from=builder /var/run/open5gs /var/run open5gs

EXPOSE 3000 5000 5001 5002

# Set the default command (adjust as needed)
CMD ["bash"]
