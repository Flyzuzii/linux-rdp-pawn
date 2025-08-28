FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    sudo wget curl git make \
    xfce4 xfce4-goodies \
    xrdp \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" ubuntu && \
    echo "ubuntu:123456" | chpasswd && \
    adduser ubuntu sudo && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN git clone https://github.com/pawn-lang/compiler.git /opt/compiler && \
    cd /opt/compiler && make && \
    ln -s /opt/compiler/pawncc /usr/bin/pawncc

EXPOSE 3389

CMD ["/usr/sbin/xrdp", "-nodaemon"]
