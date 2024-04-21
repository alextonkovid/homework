#!/bin/bash

set -e

function create-vm {
    local NAME=$1

    YC=$(cat <<END
        yc compute instance create \
        --name $NAME \
        --hostname $NAME \
        --zone ru-central1-a \
        --network-interface subnet-name=develop,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,size=20,type=network-ssd \
        --memory 4 \
        --cores 4 \
        --ssh-key ~/.ssh/cebula.pub

END
)

    eval "$YC"
}

# create-vm "kubemaster1"
# create-vm "kubemaster2"
# create-vm "kubemaster3"
create-vm "kubeworker1"
create-vm "kubeworker2"
create-vm "kubeworker3"