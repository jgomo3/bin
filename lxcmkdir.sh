#!/bin/bash

# Usage: lxcmkdir <container> <host_dirname> <container_mountpoint>

CONTAINER=$1
DIRNAME=$2
CONTAINER_MOUNTPOINT=$3

CONTAINERS_DIR=/var/lib/lxd/containers

echo Searching for container $CONTAINER owner

# Get the User ID of the owner of the container
LXC_USER=$(sudo find $CONTAINERS_DIR -maxdepth 1 -type d -and -name "${CONTAINER}*" -printf %U)
LXC_GROUP=$(sudo find $CONTAINERS_DIR -maxdepth 1 -type d -and -name "${CONTAINER}*" -printf %G)

sudo install --directory $DIRNAME --owner=$LXC_USER --group=$LXC_GROUP --mode=777

lxc config device add $CONTAINER $(basename $DIRNAME) disk source=$(readlink -f $DIRNAME) path=$CONTAINER_MOUNTPOINT
