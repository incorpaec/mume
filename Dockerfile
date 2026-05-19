FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 \
    xfce4-goodies \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    wget \
    curl \
    supervisor \
    adb \
    scrcpy \
    openjdk-17-jdk \
    python3 \
    python3-pip

RUN mkdir ~/.vnc

# no password
RUN x11vnc -storepasswd "" /root/.vnc/passwd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
