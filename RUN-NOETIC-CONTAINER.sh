#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name ubuntu20.04_cuda --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/focal:rw sarubito/ubuntu20.04_cuda:latest
