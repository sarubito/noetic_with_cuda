# noetic_with_cuda

## Discription
This repository is Dockerfile for noetic with cuda driver and toolkits.<br>
This image made from [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda). (※[base image Dockerfile](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/11.2.0/ubuntu2004/devel))<br>

See below for the version of the container environment<br>
- CUDA 11.2.0
- cuDNN 8.1.1.33
- python 3.8
- ROS [Noetic](http://wiki.ros.org/noetic/Installation/Ubuntu) <br>

Minimum enviroment of host PC<br>
- docker
- NVIDIA GPU

When you want only pull docker image, access below URL <br>
[dockerhub](https://hub.docker.com/repository/docker/sarubito2020/noetic_cuda_cudnn/general)

## Enviroment construction
1. ```cd noetic_with_cuda```
2. ```bash RUN-BUILD-20_04_IMAGE.sh```

## RUN docker container
1. ```bash RUN-NOETIC-CONTAINER.sh```

## Get in running container
1. ```bash EXEC-NOETIC-CONTAINER.sh```


## Enviroment variables for nvidia-container
1. **`NVIDIA_VISIBLE_DEVICES`** : This variable controls which GPUs will be made accessible inside the container. <br>
2. **`NVIDIA_MIG_CONFIG_DEVICES`** : This variable controls which of the visible GPUs can have their MIG configuration managed from within the container. This includes enabling and disabling MIG mode, creating and destroying GPU Instances and Compute Instances, etc.<br>
3. **`NVIDIA_MIG_MONITOR_DEVICES`** : This variable controls which of the visible GPUs can have aggregate information about all of their MIG devices monitored from within the container. This includes inspecting the aggregate memory usage, listing the aggregate running processes, etc.<br>
4. **`NVIDIA_DRIVER_CAPABILITES`** : This option controls which driver libraries/binaries will be mounted inside the container.<br>
5. **`NVIDIA_REQUIRE_*`** : A logical expression to define constraints on the configurations supported by the container.<br>
6. **`NVIDIA_DIABLE_REQUIRE`** : Single switch to disable all the constraints of the form `NVIDIA_REQUIRE_*`.
7. **`NVIDIA_REQUIRE_CUDA`** : The version of the CUDA toolkit used by the container. It is an instance of the generic `NVIDIA_REQUIRE_*` case and it is set by official CUDA images. If the version of the NVIDIA driver is insufficient to run this version of CUDA, the container will not be started.
8. **`CUDA_VERSION`** : Similar to `NVIDIA_REQUIRE_CUDA`, for legacy CUDA images.
In addition, if `NVIDIA_REQUIRE_CUDA` is not set, `NVIDIA_VISIBLE_DEVICES` and `NVIDIA_DRIVER_CAPABILITIES` will default to `all`. <br>

About detail of enviroment variables for nvidia-container : [NVIDIA/nvidia-container-runtime](https://github.com/NVIDIA/nvidia-container-runtime)
