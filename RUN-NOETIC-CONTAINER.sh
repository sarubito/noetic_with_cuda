#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name noetic_cuda --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw sarubito2020/noetic_cuda:latest
