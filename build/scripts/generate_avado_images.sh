#!/bin/bash

source ./.dappnode_profile

export DOCKER_HOST="unix:///var/run/docker.sock"
echo "-----------------------------------------------------------------------------"
figlet "DNP ADMIN"
echo "-----------------------------------------------------------------------------"

echo "Cloning & building DNP_ADMIN..."
if [ -f "/images/admin.dnp.dappnode.eth_${ADMIN_VERSION}.tar.xz" ]; then
    echo "target file already exist"
else 
    rm -rf ./DNP_ADMIN
    #git clone -b "v${ADMIN_VERSION}" https://github.com/AvadoDServer/DNP_ADMIN
    git clone https://github.com/AvadoDServer/DNP_ADMIN
    echo " cloned.. start building"
    docker-compose -f ./DNP_ADMIN/docker-compose.yml build 
    echo " done building ($1)"
    docker save admin.dnp.dappnode.eth:${ADMIN_VERSION} | xz -e9vT0 > /images/admin.dnp.dappnode.eth_${ADMIN_VERSION}.tar.xz
    cp ./DNP_ADMIN/docker-compose.yml /images/docker-compose-admin.yml
fi

echo "-----------------------------------------------------------------------------"
figlet "DNP DAPPMANAGER"
echo "-----------------------------------------------------------------------------"

echo "Cloning & building DNP_DAPPMANAGER..."
if [ -f "/images/dappmanager.dnp.dappnode.eth_${DAPPMANAGER_VERSION}.tar.xz" ]; then
    echo "target file already exist"
else 
    rm -rf ./DNP_DAPPMANAGER
    git clone https://github.com/AvadoDServer/DNP_DAPPMANAGER
    docker-compose -f ./DNP_DAPPMANAGER/docker-compose.yml build 
    docker save dappmanager.dnp.dappnode.eth:${DAPPMANAGER_VERSION} | xz -e9vT0 > /images/dappmanager.dnp.dappnode.eth_${DAPPMANAGER_VERSION}.tar.xz
    cp ./DNP_DAPPMANAGER/docker-compose.yml /images/docker-compose-dappmanager.yml
fi

echo "-----------------------------------------------------------------------------"
figlet "DNP WIFI"
echo "-----------------------------------------------------------------------------"

echo "Cloning & building DNP_WIFI..."
if [ -f "/images/wifi.dnp.dappnode.eth_${WIFI_VERSION}.tar.xz" ]; then
    echo "target file already exist"
else 
    rm -rf ./DNP_WIFI
    git clone https://github.com/AvadoDServer/DNP_WIFI
    docker-compose -f ./DNP_WIFI/docker-compose.yml build 
    docker save wifi.dnp.dappnode.eth:${WIFI_VERSION} | xz -e9vT0 > /images/wifi.dnp.dappnode.eth_${WIFI_VERSION}.tar.xz
    cp ./DNP_WIFI/docker-compose.yml /images/docker-compose-wifi.yml
    cp ./DNP_WIFI/wifi.dnp.dappnode.eth.env /images/wifi.dnp.dappnode.eth.env
fi


echo "-----------------------------------------------------------------------------"
figlet "DNP BIND"
echo "-----------------------------------------------------------------------------"


echo "Cloning & building DNP_BIND..."
if [ -f "/images/bind.dnp.dappnode.eth_${BIND_VERSION}.tar.xz" ]; then
    echo "target file already exist"
else 
    rm -rf ./DNP_BIND
    git clone https://github.com/AvadoDServer/DNP_BIND
    docker-compose -f ./DNP_BIND/docker-compose.yml build 
    docker save bind.dnp.dappnode.eth:${BIND_VERSION} | xz -e9vT0 > /images/bind.dnp.dappnode.eth_${BIND_VERSION}.tar.xz
    cp ./DNP_BIND/docker-compose.yml /images/docker-compose-bind.yml
    cp ./DNP_BIND/bind.dnp.dappnode.eth.env /images/bind.dnp.dappnode.eth.env
fi

mkdir -p dappnode/DNCORE


echo "These are the images that will be added to the ISO"
ls -l /images/

echo "Coping dappnode_all_docker_images.tar.xz to dappnode dir..."
cp /images/* dappnode/DNCORE

echo "These are the images that are copied to dappnode/CORE"
ls -l dappnode/CORE


echo "-----------------------------------------------------------------------------"
figlet "Finished"
echo "-----------------------------------------------------------------------------"
