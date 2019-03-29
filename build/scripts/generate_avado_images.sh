#!/bin/bash

source ./.avado_profile

echo "Cleaning previous files"
rm -rf ./DNP_ADMIN

echo "Cloning & building DNP_ADMIN..."
#git clone -b "v${ADMIN_VERSION}" https://github.com/AvadoDServer/DNP_ADMIN
git clone https://github.com/AvadoDServer/DNP_ADMIN
docker-compose -f ./DNP_ADMIN/docker-compose.yml build 
docker save admin.dnp.dappnode.eth:${ADMIN_VERSION} | xz -e9vT0 > /images/admin.dnp.dappnode.eth_${ADMIN_VERSION}.tar.xz

echo "Cloning & building DNP_DAPPMANAGER..."
git clone https://github.com/AvadoDServer/DNP_DAPPMANAGER
docker-compose -f ./DNP_DAPPMANAGER/docker-compose.yml build 
docker save dappmanager.dnp.dappnode.eth:${DAPPMANAGER_VERSION} | xz -e9vT0 > /images/dappmanager.dnp.dappnode.eth_${DAPPMANAGER_VERSION}.tar.xz


echo "Coping dappnode_all_docker_images.tar.xz to dappnode dir..."
cp /images/* dappnode/

echo "Finished!"
