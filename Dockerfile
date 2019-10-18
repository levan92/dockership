# FROM nvcr.io/nvidia/tensorflow:18.06-py3
# FROM nvcr.io/nvidia/tensorflow:18.10-py3
FROM nvcr.io/nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

RUN apt-get -y update
# RUN apt-get -y upgrade

RUN apt-get -y install python3.5-tk \
    python3-pip
    # python3-dev

RUN apt-get -y install sudo \
    apt-transport-https 

RUN apt-get -y install libcanberra-gtk-module \
    libcanberra-gtk3-module \
    dbus-x11

RUN apt-get update &&\
    apt-get -y install build-essential cmake pkg-config libx11-dev libatlas-base-dev libgtk-3-dev libboost-python-dev

RUN apt-get install -y libopencv-calib3d2.4v5 \
    libopencv-contrib2.4v5 \
    libopencv-core2.4v5 \
    libopencv-features2d2.4v5 \
    libopencv-flann2.4v5 \
    libopencv-gpu2.4v5 \
    libopencv-highgui2.4v5 \
    libopencv-imgproc2.4v5 \
    libopencv-legacy2.4v5 \
    libopencv-ml2.4v5 \
    libopencv-objdetect2.4v5 \
    libopencv-ocl2.4v5 \
    libopencv-photo2.4v5 \
    libopencv-stitching2.4v5 \
    libopencv-superres2.4v5 \
    libopencv-ts2.4v5 \
    libopencv-video2.4v5 \
    libopencv-videostab2.4v5 \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get -y autoremove

RUN pip3 install --no-cache-dir --upgrade pip 
RUN pip3 install --no-cache-dir numpy==1.15.3 \
    scipy==1.0.0 \
    matplotlib \
    Pillow==5.3.0 \
    opencv-python
RUN pip3 install --no-cache-dir tensorflow==1.9.0 \
    tensorflow-gpu==1.9.0 \
    Keras==2.2.4

RUN pip3 install --no-cache-dir torch==1.3.0+cu92 torchvision==0.4.1+cu92 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip3 install --no-cache-dir GPUtil==1.4.0 \
    tqdm==4.28.1 \
    sqlalchemy==1.3.7

RUN rm -rf dlib-19.13.tar.bz2 dlib-19.13 &&\
    wget http://dlib.net/files/dlib-19.13.tar.bz2 &&\
    tar xvf dlib-19.13.tar.bz2 &&\
    cd dlib-19.13 &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    CMAKE_BUILD_PARALLEL_LEVEL=8 cmake --build . --config Release &&\
    make install &&\
    ldconfig &&\
    cd ..  &&\
    pkg-config --libs --cflags dlib-1  &&\
    python3 setup.py install

RUN pip3 install face_recognition

RUN pip3 install flask imutils

RUN pip3 install scikit-image
#   - lmdb
#   - python-lmdb
#   - natsort
#   - fire
#   - python=3.6
#   - tensorflow-gpu
#   - pillow
#   - pip:
#       - torch
#       - torchvision
#       - jupyter
#       - pytesseract

RUN useradd -m user && echo "user:pwd" | chpasswd && adduser user sudo
USER user

WORKDIR /home

