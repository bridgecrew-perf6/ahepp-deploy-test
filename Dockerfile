FROM debian:bullseye-slim
RUN dpkg-reconfigure debconf -f noninteractive -p critical
RUN echo 'root:root' | chpasswd

RUN apt-get update && apt-get install --no-install-recommends -y \
    ssh

RUN groupadd -g 1000 dev \
    && useradd -m -u 1000 -g dev dev

RUN mkdir /ws \
    && chown 1000:1000 /ws

WORKDIR /ws
USER dev
