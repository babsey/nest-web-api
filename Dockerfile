FROM ubuntu:16.04

LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cython \
    libgsl0-dev \
    libltdl7-dev \
    libncurses5-dev \
    libreadline6-dev \
    python-all-dev \
    python-numpy \
    python-pip \
    git

RUN pip install flask flask_cors

WORKDIR /tmp
RUN git clone https://github.com/nest/nest-simulator && \
    mkdir /tmp/nest-build

WORKDIR /tmp/nest-build
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest/ ../nest-simulator && \
    make && \
    make install && \
    rm -rf /tmp/*

COPY ./ /nest-web-api
WORKDIR /nest-web-api

EXPOSE 5000
RUN chmod 755 entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
