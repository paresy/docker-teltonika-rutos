FROM ubuntu:22.04

WORKDIR /home

#Required since Debian Buster
ENV FORCE_UNSAFE_CONFIGURE=1

#Fix getting stuck on installing tzdata
ENV DEBIAN_FRONTEND noninteractive

#Which version should we build
ARG RUTOS_VERSION
ARG RUTOS_CHECKSUM

#Based on https://wiki.teltonika-networks.com/view/RUTOS_Software_Development_Kit_instructions
RUN \
    apt-get update &&\
    apt-get install -y  \
        binutils \
        binutils-gold \
        bison \
        build-essential  \
        bzip2 \
        ca-certificates \
        curl \
        cmake \
        default-jdk \
        device-tree-compiler \
        devscripts \
        ecj  \
        file  \
        flex  \
        fuse \
        g++  \
        gawk \
        gcc  \
        gcc-multilib  \
        gcovr \
        gengetopt \
        gettext \
        git \
        gnupg \
        groff \
        gperf \
        help2man \
        java-wrappers \
        java-propose-classpath \
        jq \
        libc6-dev \
        libffi-dev \
        libexpat-dev \
        libncurses5-dev \
        libpcre3-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml-parser-perl \
        lz4 \
        liblz4-dev \
        libzstd-dev \
        make \
        ocaml \
        ocaml-findlib \
        ocaml-nox \
        patch \
        pkg-config \
        psmisc \
        python-is-python3 \
        python3.11 \
        python3.11-dev \
        python3-setuptools \
        python3-yaml \
        rsync \
        ruby \
        sharutils \
        subversion \
        swig \
        u-boot-tools \
        unzip \
        uuid-dev \
        vim-common \
        wget \
        zip \
        zlib1g-dev \
        # These packages are also required \
        sudo

#SDK needs NodeJS 20.x which is not being shipped by Ubuntu 22.04
RUN \
    curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    sudo apt -y install nodejs && \
    npm install -g node-gyp

#SDK needs esbuild and it will wait interactively for the user to press enter if it is not installed
RUN \
   npm install -g esbuild

#Building with root permissions will fail miserably
#See: https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user

#Set user, group and setup sudo
ARG USERNAME=rutx
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_GID --gid $USERNAME -m $USERNAME
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME

#Switch to user
USER $USER_UID:$USER_GID

#Download/Unpack
RUN \
    cd ~ && \
    export RUTOS_FILE=RUTX_R_GPL_${RUTOS_VERSION}.tar.gz && \
    export RUTOS_SHORT_VERSION=$(echo $RUTOS_VERSION | sed 's/0//g' | sed 's/^\.//') && \
    wget https://firmware.teltonika-networks.com/${RUTOS_SHORT_VERSION}/RUTX/${RUTOS_FILE} && \
    echo "${RUTOS_CHECKSUM} ${RUTOS_FILE}" | md5sum -c --status && \
    tar -xf ${RUTOS_FILE} && \
    rm ${RUTOS_FILE}

#Build
RUN \
    cd ~ && \
    cd rutos-ipq40xx-rutx-sdk &&\
    ./scripts/feeds update -a &&\
    make -j $(nproc) V=s