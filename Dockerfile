FROM ubuntu:18.04

WORKDIR /home

#Required since Debian Buster
ENV FORCE_UNSAFE_CONFIGURE=1

#Which version should we build
ARG RUTOS_VERSION
ARG RUTOS_CHECKSUM

#Based on https://wiki.teltonika-networks.com/view/RUTOS_Software_Development_Kit_instructions
RUN \
	apt-get update &&\
	apt-get install -y  \
        build-essential  \
        ccache  \
        ecj  \
        fastjar  \
        file  \
        g++  \
        gawk  \
        gettext  \
        git  \
        java-propose-classpath  \
        libelf-dev  \
        libncurses5-dev  \
        libncursesw5-dev  \
        libssl1.0-dev  \
        python  \
        python2.7-dev  \
        python3  \
        unzip  \
        wget  \
        python3-distutils  \
        python3-setuptools  \
        rsync  \
        subversion  \
        swig  \
        time  \
        libffi-dev  \
        libtool  \
        xsltproc  \
        zlib1g-dev  \
        u-boot-tools  \
        nodejs  \
        nodejs-dev  \
        node-gyp  \
        npm  \
        jq \
        nano \
        sudo


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
    wget https://wiki.teltonika-networks.com/gpl/${RUTOS_VERSION} && \
    echo ${RUTOS_CHECKSUM} ${RUTOS_VERSION} | md5sum -c --status && \
    tar -xf ${RUTOS_VERSION} && \
    rm ${RUTOS_VERSION}

#Build
RUN \
    cd ~ && \
    cd rutos-ipq40xx-rutx-gpl &&\
    ./scripts/feeds update -a &&\
    make -j $(nproc)