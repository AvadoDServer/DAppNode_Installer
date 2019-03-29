#!/bin/sh
dockerd &
sleep 5;

rm -f /images/*.tar.xz
rm -f /images/*.yml
rm -f /images/*.env
rm -f /images/*.json
rm -f /images/*.iso

if [ "$BUILD" = true ]; then
    /usr/src/app/generate_docker_images.sh
else
    /usr/src/app/download_core.sh
fi

# build the AVADO specific images
/usr/src/app/generate_avado_images.sh

#file generated to detectd ISO installation
touch dappnode/iso_install.log

if [ "$UBUNTU" = "18.04" ]; then
    /usr/src/app/generate_dappnode_iso.18.04.sh
else
    /usr/src/app/generate_dappnode_iso.16.04.sh
fi
