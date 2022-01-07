# noetic_with_cuda

## Discription
This repository is Dockerfile for noetic with cuda driver and toolkits.<br>
This image made from [nvidia/opengl](https://hub.docker.com/r/nvidia/opengl).<br>
If you want change CUDA version, please reference from [nvidia developer](https://developer.nvidia.com/cuda-downloads).<br>

See below for the version of the container environment<br>
- python 3.8
- CUDA 10.2 <br>

## Enviroment construction
1. ```cd noetic_with_cuda```
2. ```bash RUN-BUILD-20_04_IMAGE.sh```

## RUN docker container
1. ```bash RUN-NOETIC-CONTAINER.sh```

## Get in running container
1. ```bash EXEC-NOETIC-CONTAINER.sh```
