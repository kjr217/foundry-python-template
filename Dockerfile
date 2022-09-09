FROM ghcr.io/foundry-rs/foundry:latest

# Install Python 3.9

WORKDIR /app 

ARG PYTHON_VERSION=3.9.9

# install build dependencies and needed tools
RUN apk add \
    wget \
    gcc \
    make \
    zlib-dev \
    libffi-dev \
    openssl-dev \
    musl-dev

# download and extract python sources
RUN cd /opt \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \                                              
    && tar xzf Python-${PYTHON_VERSION}.tgz

# build python and remove left-over sources
RUN cd /opt/Python-${PYTHON_VERSION} \ 
    && ./configure --prefix=/usr --enable-optimizations --with-ensurepip=install \
    && make install \
    && rm /opt/Python-${PYTHON_VERSION}.tgz /opt/Python-${PYTHON_VERSION} -rf

COPY . .

# We install this directly as we dont need a virtual environment in Docker 
RUN pip3 install -r requirements.txt 

RUN forge install 

ENTRYPOINT [ "/bin/sh" ] 

