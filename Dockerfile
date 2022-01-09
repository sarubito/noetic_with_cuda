FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04

ARG CUDA_VERSION=cuda-11.2
ARG ROS_VERSION=noetic
ARG PYTHON_VERSION=python3
ARG TZ=Asia/Tokyo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ ${TZ}

## nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics, compute, video, utility


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    mesa-utils \
    x11-apps \
    git \
    vim \
    cmake \
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
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    libglvnd-dev libglvnd-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

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

## Setting working directry
WORKDIR /root/WORKDIR
