# noetic_with_cuda

## Discription
This repository is Dockerfile for noetic with cuda driver and toolkits.<br>
This image made from [nvidia/opengl](https://hub.docker.com/r/nvidia/opengl).<br>
If you want change CUDA version, please reference from [nvidia developer](https://developer.nvidia.com/cuda-downloads).<br>

See below for the version of the container environment<br>
- CUDA 11.2
- python 3.8
- ROS [Noetic](http://wiki.ros.org/noetic/Installation/Ubuntu) <br>

Minimum enviroment of host PC<br>
- docker
- NVIDIA GPU

When you need CUDA and cuDNN, pull below image <br>
[dockerhub](https://hub.docker.com/repository/docker/sarubito2020/noetic_cuda_cudnn/general)

## Enviroment construction
1. ```cd noetic_with_cuda```
2. ```bash RUN-BUILD-20_04_IMAGE.sh```

## RUN docker container
1. ```bash RUN-NOETIC-CONTAINER.sh```

## Get in running container
1. ```bash EXEC-NOETIC-CONTAINER.sh```
