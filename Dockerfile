FROM ubuntu:16.04
LABEL maintainer="Alvis Zhao<alvisisme@gmail.com>"
RUN sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install unzip wget python

ENV ANDROID_NDK_VERSION r13b

RUN wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    unzip -qq android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    /bin/bash android-ndk-${ANDROID_NDK_VERSION}/build/tools/make-standalone-toolchain.sh --arch=arm64 \
    --platform=android-21 --toolchain=aarch64-linux-android-4.9 --stl=libc++ --install-dir=/opt/arm64-android-toolchain && \
    rm -rf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
    rm -rf android-ndk-${ANDROID_NDK_VERSION}

ENV PATH=$PATH:/opt/arm64-android-toolchain/bin
ENV CC=/opt/arm64-android-toolchain/bin/aarch64-linux-android-gcc
ENV CXX=/opt/arm64-android-toolchain/bin/aarch64-linux-android-g++
ENV LINK=/opt/arm64-android-toolchain/bin/aarch64-linux-android-g++
ENV LD=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ld
ENV AR=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ar
ENV RANLIB=/opt/arm64-android-toolchain/bin/aarch64-linux-android-ranlib
ENV STRIP=/opt/arm64-android-toolchain/bin/aarch64-linux-android-strip
ENV OBJCOPY=/opt/arm64-android-toolchain/bin/aarch64-linux-android-objcopy
ENV OBJDUMP=/opt/arm64-android-toolchain/bin/aarch64-linux-android-objdump
ENV NM=/opt/arm64-android-toolchain/bin/aarch64-linux-android-nm
ENV AS=/opt/arm64-android-toolchain/bin/aarch64-linux-android-as
ENV SYSROOT=/opt/arm64-android-toolchain/sysroot
