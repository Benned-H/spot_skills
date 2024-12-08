#!/bin/bash

install_samdetic() {
    if ! command -v /docker/py3.10/bin/python3.10 &> /dev/null; then
        wget -P /docker/ https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
        tar -xzvf /docker/Python-3.10.0.tgz -C /docker/
        cd /docker/Python-3.10.0
        ./configure --prefix=/docker/py3.10
        make -j$(nproc)
        make altinstall
        cd /docker
        rm -rf /docker/Python-3.10.0.tgz /docker/Python-3.10.0
    fi
    ln -s /docker/py3.10/bin/python3.10 /usr/local/bin/python3.10
    ln -s /docker/py3.10/bin/pip3.10 /usr/local/bin/pip3.10

    pip3.10 install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cu121
    pip3.10 install --no-cache-dir opencv-python pyyaml rospkg

    git clone https://github.com/facebookresearch/sam2.git /docker/sam2
    pip3.10 install -e /docker/sam2

    git clone https://github.com/facebookresearch/detectron2.git /docker/detectron2
    pip3.10 install -e /docker/detectron2

    git clone https://github.com/facebookresearch/Detic.git --recurse-submodules /docker/Detic
    pip3.10 install -r /docker/Detic/requirements.txt
}

install_samdetic
# Run the main process specified as CMD in the Dockerfile
exec "$@"
