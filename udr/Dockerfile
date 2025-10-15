FROM open5gs-base:latest AS builder

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
      libsctp1 \
      libssl3 \
      libnghttp2-14 \
      libmongoc-1.0-0 \
      curl \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libtalloc2 \
    libmicrohttpd12 \
    libcurl4-gnutls-dev \
    libyaml-0-2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /open5gs

#COPY --from=builder /opt/open5gs/build/nrf /open5gs/nrf
COPY --from=builder /opt/open5gs/install/bin/open5gs-udrd /open5gs/open5gs-udrd
COPY --from=builder /opt/open5gs/install/lib /open5gs/lib
COPY --from=builder /opt/open5gs/install/var/log/open5gs /open5gs/log
COPY ./config.yaml /open5gs/config.yaml

RUN echo "/open5gs/lib" > /etc/ld.so.conf.d/open5gs.conf \
  && echo "/open5gs/lib/x86_64-linux-gnu" >> /etc/ld.so.conf.d/open5gs.conf \
  && ldconfig
EXPOSE 8000 8940

HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:8000/health || exit 1

#RUN LD_LIBRARY_PATH=/open5gs/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

#ENTRYPOINT ["/open5gs/open5gs-nrfd", "-c", "/open5gs/config.yaml"]
ENTRYPOINT ["/open5gs/open5gs-udrd", "-c", "/open5gs/config.yaml"]

# Register library path

# (Optional) create a wrapper start script
#COPY start-nrf.sh /usr/local/bin/start-nrf.sh
#RUN chmod +x /usr/local/bin/start-nrf.sh

#ENTRYPOINT [ "/usr/local/bin/start-nrf.sh" ]
