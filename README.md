# docker-ros2-ospl-ce
A dockerfile to build a ROS2 + OpenSplice CE container

## How to build an OpenSplice CE container image ?

```bash
$> docker build -t ospl-ce opensplice
```

## How to build ROS2 container image ?

```bash
$> docker build -t ros2 .
```

## How to run ROS2 container ?

```bash
$> docker run -it --name ros2 --rm ros2  bash
root@xxxxxxxxx: source /root/opensplice/install/HDE/x86_64.linux/release.com
root@xxxxxxxxx: source /root/ros2_ws/install/local_setup.bash
root@xxxxxxxxx: ros2 --help
```
