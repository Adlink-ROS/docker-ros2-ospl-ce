FROM ospl-ce
MAINTAINER ChesterTseng "chester.tseng@adlinktech.com"

# Set up locales to en_US.UTF-8 and proxy
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf \
    && apt-get update \
    && apt-get install -y wget git locales \
    && locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 

ENV LANG=en_US.UTF-8

# Import key from ros.org and apt souce
RUN apt-get install -y lsb-release \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# Install al dependency packages
RUN apt-get update \
    && apt-get install -y build-essential cppcheck cmake libopencv-dev libpoco-dev libpocofoundation9v5 libpocofoundation9v5-dbg python-empy python3-dev python3-empy python3-nose python3-pip python3-setuptools python3-vcstool python3-yaml libtinyxml-dev libeigen3-dev \
    && apt-get install -y clang-format pydocstyle pyflakes python3-coverage python3-mock python3-pep8 uncrustify \
    && pip3 install argcomplete flake8 flake8-import-order \
    && apt-get install -y libasio-dev libtinyxml2-dev

# Create ros2 workspace
RUN mkdir -p "$HOME/ros2_ws/src" 

ARG RMW_IMPLEMENATION=rmw_opensplice_cpp

ENV RMW_IMPLEMENATION=$RMW_IMPLEMENATION

ARG ROS2_VER=master

RUN cd /root/ros2_ws/ && wget https://raw.githubusercontent.com/ros2/ros2/$ROS2_VER/ros2.repos && vcs-import src < ros2.repos

ADD build.sh /root

RUN cd /root && chmod +x "build.sh" && /bin/bash -c "./build.sh"

VOLUME ["/root/ros2_ws"]

WORKDIR /root/ros2_ws
