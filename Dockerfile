FROM andrewstucki/llvm9-musl-toolchain

RUN apk add --no-cache \
    linux-headers \
    curl \
    python && \
    \
    mkdir -p /tmp/boost && \
    cd /tmp && \
    curl -s -L https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2 | tar -xjf - -C boost --strip-components 1 && \
    cd /tmp/boost && \
    \
    ./bootstrap.sh --with-toolset=clang --prefix=/usr/ && \
    ./b2 toolset=clang link=static runtime-link=static --without-python stage && \
    ./b2 toolset=clang link=static runtime-link=static --without-python install && \
    rm -rf /tmp/boost && \
    apk del --purge curl python
