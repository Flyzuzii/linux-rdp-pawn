FROM ubuntu:20.04

# Non-interactive install
ENV DEBIAN_FRONTEND=noninteractive

# Update & install XRDP + XFCE
RUN apt-get update && apt-get install -y \
    xrdp xfce4 xfce4-goodies dbus-x11 sudo nano curl wget net-tools \
    && rm -rf /var/lib/apt/lists/*

# Buat user Fauzi
RUN useradd -m -s /bin/bash Fauzi && echo "Fauzi:123456" | chpasswd && adduser Fauzi sudo

# Set XFCE sebagai default session
RUN echo "xfce4-session" > /home/Fauzi/.xsession && chown Fauzi:Fauzi /home/Fauzi/.xsession

# Fix startwm.sh supaya gak blank screen
RUN sed -i.bak '/test -x \/etc\/X11\/Xsession && exec \/etc\/X11\/Xsession/ s/^/#/' /etc/xrdp/startwm.sh \
    && echo "startxfce4" >> /etc/xrdp/startwm.sh

# Expose RDP port
EXPOSE 3389
CMD ["/bin/bash", "-c", "service xrdp-sesman start && service xrdp start && tail -f /dev/null"]
# Jalankan XRDP
CMD ["/usr/sbin/xrdp-sesman", "--nodaemon"]
