#!/bin/sh
rm -f /var/run/docker.pid
dockerd &
sleep 5;


netstat -ln

# rm -f /images/*.tar.xz
# rm -f /images/*.yml
# rm -f /images/*.env
# rm -f /images/*.json
rm -f /images/*.iso


#if [ "$BUILD" = true ]; then
    # build the AVADO specific images
    /usr/src/app/generate_avado_images.sh
#fi

mkdir -p dappnode/DNCORE

#if [ "$DOWNLOAD" = true ]; then
    /usr/src/app/download_core.sh
#fi

echo -e "\e[32mCopying files...\e[0m"
cp /images/*.tar.xz dappnode/DNCORE
cp /images/*.yml dappnode/DNCORE
cp /images/*.json dappnode/DNCORE
cp /images/*.env dappnode/DNCORE
cp ./.dappnode_profile dappnode/DNCORE

echo -e "\e[32m.dappnode_profile\e[0m"
cat dappnode/DNCORE/.dappnode_profile


echo -e "\e[32mTarget files for iso\e[0m"

ls -lR dappnode


#file generated to detectd ISO installation
touch dappnode/iso_install.log

/usr/src/app/generate_dappnode_iso_debian.sh

