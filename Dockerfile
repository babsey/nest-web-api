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

RUN pip install flask==0.12.4 flask_cors

WORKDIR /
RUN git clone https://github.com/nest/nest-simulator --depth 1 && \
    mkdir /nest-build

WORKDIR /nest-build
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest/ ../nest-simulator && \
    make && \
    make install && \
    rm -rf /nest-simulator /nest-build

# ENV LISTEN_PORT 5000
# ENV UWSGI_INI /opt/nest-web-api/uwsgi.ini
# ENV NGINX_WORKER_PROCESSES auto

COPY ./app /opt/nest-web-api
WORKDIR /opt/nest-web-api

EXPOSE 5000
RUN chmod 755 entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
