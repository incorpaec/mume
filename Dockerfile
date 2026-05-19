FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    dbus-x11 \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    supervisor \
    wget \
    curl \
    git \
    nano \
    net-tools \
    adb \
    scrcpy \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create VNC directory
RUN mkdir -p /root/.vnc

# Empty VNC password
RUN x11vnc -storepasswd "" /root/.vnc/passwd

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose noVNC port
EXPOSE 8080

CMD ["/usr/bin/supervisord", "-n"]
