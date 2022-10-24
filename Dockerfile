FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        openssl-dev \
        hwloc-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      git checkout dev && \
      mkdir build && \
      cmake -DWITH_HTTPD=OFF -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
