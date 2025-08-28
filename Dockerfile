FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install XRDP + XFCE + tools dasar
RUN apt-get update && apt-get install -y \
    xrdp xfce4 xfce4-terminal sudo wget git build-essential \
    && rm -rf /var/lib/apt/lists/*

# Buat user Fauzi dengan password 123456
RUN useradd -m -s /bin/bash Fauzi && echo 'Fauzi:123456' | chpasswd && adduser Fauzi sudo

# Konfigurasi XRDP agar masuk ke XFCE
RUN echo "startxfce4" > /etc/skel/.xsession \
    && echo "startxfce4" > /home/Fauzi/.xsession \
    && chown Fauzi:Fauzi /home/Fauzi/.xsession

EXPOSE 3389

CMD ["/usr/sbin/xrdp", "-nodaemon"]
