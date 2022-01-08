## https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html
#!/bin/bash

export cuda_version=cuda10.2
export cudnn_version=8.3.1.22

tar -xvf cudnn-linux-x86_64-8.3.1.22_${cuda_version}-archive.tar.xz
cp cudnn-*-archive/include/cudnn*.h /usr/local/${cuda_version}/include
cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
dpkg -i cudnn-local-repo-ubuntu1804-8.3.1.22_1.0-1_amd64.deb
apt-key add /var/cudnn-local-repo-ubuntu1804-8.3.1.22/7fa2af80.pub
apt-get update
apt-get install libcudnn8=${cudnn_version}-1+${cuda_version}
apt-get install libcudnn8-dev=${cudnn_version}-1+${cuda_version}
apt-get install libcudnn8-sample=${cudnn_version}-1+${cuda_version}
apt-get install libcudnn8-samples=${cudnn_version}-1+${cuda_version}
