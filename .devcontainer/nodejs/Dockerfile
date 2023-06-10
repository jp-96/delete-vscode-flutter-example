# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.195.0/containers/javascript-node/.devcontainer/base.Dockerfile
# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 16, 14, 12, 16-bullseye, 14-bullseye, 12-bullseye, 16-buster, 14-buster, 12-buster
ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment if you want to install an additional version of node using nvm
# ARG EXTRA_NODE_VERSION=10
# RUN su node -c "umask 0002 && ./usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment if you want to install more global node modules
# RUN su node -c "npm install -g <your-package-list-here>"

# OpenJDK
ARG OPENJDK_VERSION="11-jdk"
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends openjdk-${OPENJDK_VERSION}


# Android SDK
# https://developer.android.com/tools
ENV ANDROID_SDK_TOOLS_VERSION=8512546
ENV ANDROID_PLATFORM_VERSION=33
ENV ANDROID_BUILD_TOOLS_VERSION=33.0.0
ENV ANDROID_HOME=/home/node/android-sdk
ENV ANDROID_SDK_ROOT="${ANDROID_HOME}"
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin
ENV PATH=${PATH}:${ANDROID_HOME}/platform-tools
ENV PATH=${PATH}:${ANDROID_HOME}/emulator

WORKDIR /home/node
USER node

RUN curl -C - --output android-sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip
RUN	mkdir -p ${ANDROID_HOME}/
RUN	unzip -q android-sdk-tools.zip -d ${ANDROID_HOME}/cmdline-tools/
RUN rm android-sdk-tools.zip
RUN yes | sdkmanager --licenses
RUN touch $HOME/.android/repositories.cfg
RUN sdkmanager platform-tools
#RUN yes | sdkmanager "platforms;android-${ANDROID_PLATFORM_VERSION}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
RUN sdkmanager --install "cmdline-tools;latest"
## create emulator android	
RUN sdkmanager emulator
#RUN sdkmanager "system-images;android-${ANDROID_PLATFORM_VERSION};google_apis;x86_64"
#RUN echo | avdmanager create avd -n Android${ANDROID_PLATFORM_VERSION} -k "system-images;android-${ANDROID_PLATFORM_VERSION};google_apis;x86_64"

# Flutter SDK
# https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.3.4"
# Make sure to use the needed channel and version for this.
ENV FLUTTER_HOME=/home/node/flutter-sdk
ENV PATH=${PATH}:${FLUTTER_HOME}/bin

RUN curl -C - --output flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz
RUN tar -xf flutter.tar.xz \
    && mv flutter ${FLUTTER_HOME} \
	&& rm flutter.tar.xz
RUN flutter config --android-sdk "${ANDROID_SDK_ROOT}"
RUN yes | flutter doctor --android-licenses
RUN flutter config --no-analytics
RUN flutter update-packages

USER root
