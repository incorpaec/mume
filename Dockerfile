FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    git \
    python3 \
    python3-pip \
    openjdk-17-jdk \
    adb \
    nano \
    iputils-ping \
    net-tools \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Android SDK directory
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Create SDK directory
RUN mkdir -p $ANDROID_HOME/cmdline-tools

WORKDIR /opt

# Download Android command line tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip

RUN unzip cmdline-tools.zip -d $ANDROID_HOME/cmdline-tools

RUN mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest

# Accept licenses
RUN yes | sdkmanager --licenses

# Install platform tools
RUN sdkmanager "platform-tools" "platforms;android-34"

# Install Python packages
RUN pip3 install --no-cache-dir \
    flask \
    requests \
    uiautomator2 \
    adbutils

# App directory
WORKDIR /app

# Copy files
COPY . /app

# Expose API port
EXPOSE 5000

# Start shell by default
CMD ["bash"]