FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04

ARG CUDA_VERSION=cuda-11.2
ARG ROS_VERSION=noetic
ARG PYTHON_VERSION=python3
ARG TZ=Asia/Tokyo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ ${TZ}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    mesa-utils \
    x11-apps \
    git \
    vim \
    build-essential \
    curl \
    ca-certificates \
    wget \
    gnupg2 \
    lsb-release \ 
    mesa-utils \
    net-tools \
    iputils-ping \
    python3-pip \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    libglvnd-dev libglvnd-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python

ENV PATH="/usr/local/${CUDA_VERSION}/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH"

## Install ROS #################
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

SHELL ["/bin/bash", "-c"] 
RUN apt update -y \
    && apt install -y --no-install-recommends \
    ros-${ROS_VERSION}-desktop-full \
    ros-${ROS_VERSION}-image-* \
    ros-${ROS_VERSION}-vision-msgs \
    ros-${ROS_VERSION}-libuvc-camera \
    ros-${ROS_VERSION}-camera-calibration \
    ros-${ROS_VERSION}-ddynamic-reconfigure \
    ${PYTHON_VERSION}-rosdep \
    ${PYTHON_VERSION}-rosinstall \
    ${PYTHON_VERSION}-rosinstall-generator \
    ${PYTHON_VERSION}-wstool \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    cd /opt/ros/${ROS_VERSION}/share/ros && \
    rosdep init && \
    rosdep update && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-catkin-tools

RUN echo "source /opt/ros/${ROS_VERSION}/setup.bash" >> ~/.bashrc
###############################

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    usbutils

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install rospkg
RUN pip3 uninstall -y  pillow
RUN pip3 install pillow
RUN pip3 install empy

#WORKDIRはcdのような感じ
WORKDIR /root/cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4.tar.gz
RUN tar -xvf cmake-3.21.4.tar.gz && rm -f cmake-3.21.4.tar.gz
WORKDIR /root/cmake/cmake-3.21.4
RUN bash bootstrap && make && make install

## Setting working directry
RUN echo "source /opt/ros/${ROS_VERSION}/setup.bash" >> ~/.bashrc
WORKDIR /root/WORKDIR
