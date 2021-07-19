FROM debian:buster

# https://gstreamer.freedesktop.org/documentation/video4linux2/v4l2src.html?gi-language=c#example-launch-lines
# Since 1.14, the use of libv4l2 has been disabled due to major bugs in the emulation layer. To enable usage of this library, set the environment variable GST_V4L2_USE_LIBV4L2=1.
env GST_V4L2_USE_LIBV4L2=1

# Platform dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -qq install build-essential cmake cmake-data curl git libx264-dev pkg-config
# xz-utils

# TODO 
# Install raspberry pi userland
# Might not be needed (tbd)
# This repository contains the source code for the ARM side libraries used on Raspberry Pi. 
# These typically are installed in /opt/vc/lib and includes source for the ARM side code to interface to:
# EGL, mmal, GLESv2, vcos, openmaxil, vchiq_arm, bcm_host, WFC, OpenVG.
# https://github.com/raspberrypi/userland
# WORKDIR "/root"
# RUN git clone https://github.com/raspberrypi/userland.git
# WORKDIR "/root/userland"
# RUN git checkout 97bc8180ad682b004ea224d1db7b8e108eda4397
# RUN ./buildme

# Required to link against Raspberry Pi userland libs
# TODO Raspberry Pi OS 64-bit will move these to /usr/
# https://www.raspberrypi.org/forums/viewtopic.php?t=275370
RUN echo "/opt/vc/lib" > /etc/ld.so.conf.d/00-vmcs.conf
RUN ldconfig

# install gstreamer universe
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -qq install \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-* \
    gstreamer1.0-tools \
    gstreamer1.0-x

