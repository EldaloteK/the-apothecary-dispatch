# Base image.
FROM ubuntu:22.04

# Install necessary tools.
RUN set -ex; \
    apt-get update && \
    apt-get install -y git curl unzip openjdk-8-jdk sudo

# Create a new app user and app working directory.
RUN set -ex; \
    useradd -ms /bin/bash app -d /home/app -G sudo -u 1000 -p "$(openssl passwd -1 tad)" && \
    mkdir -p /app && \
    chown app:app /app

# Switch to app user.
USER app
WORKDIR /app

# Install Android SDK command line tools.
RUN set -ex; \
    curl --output cmd-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip" && \
    mkdir -p /home/app/android-sdk && \
    unzip cmd-tools.zip -d /home/app/android-sdk && \
    cd /home/app/android-sdk && \
    mv cmdline-tools latest && \
    mkdir cmdline-tools && \
    mv latest cmdline-tools

ENV ANDROID_SDK_ROOT="/home/app/android-sdk"

# Install Flutter.
RUN cd /home/app && git clone https://github.com/flutter/flutter.git -b stable

# Set environment path for Flutter and Android SDK.
ENV PATH="$PATH:/home/app/flutter/bin:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"

# Install Android SDK and accept licenses.
RUN set -ex; \
    yes "y" | sdkmanager "tools" && \
    yes "y" | sdkmanager --update && \
    yes "y" | sdkmanager "cmdline-tools;latest" "platforms;android-29" "build-tools;28.0.3" "platform-tools" "emulator" && \
    yes "y" | sdkmanager --licenses

# Finalizing Flutter installation.
RUN flutter doctor

EXPOSE 38387

# CMD [ "flutter", "run" , "-d", "web-server", "--web-port 38387", "--web-hostname 0.0.0.0"]