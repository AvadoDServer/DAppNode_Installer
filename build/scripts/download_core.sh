#!/bin/bash
 
source ./.dappnode_profile

DAPPNODE_CORE_DIR="/images/"

WGET="wget"

#components=(BIND IPFS VPN WAMP WIFI)
#components=(BIND IPFS VPN WAMP WIFI)
components=(WAMP IPFS VPN)

# The indirect variable expansion used in ${!ver##*:} allows us to use versions like 'dev:development'
# If such variable with 'dev:'' suffix is used, then the component is built from specified branch or commit.
for comp in "${components[@]}"; do
    ver="${comp}_VERSION"
    eval "${comp}_URL=\"https://github.com/dappnode/DNP_${comp}/releases/download/v${!ver}/${comp,,}.dnp.dappnode.eth_${!ver}.tar.xz\""
    eval "${comp}_YML=\"https://github.com/dappnode/DNP_${comp}/releases/download/v${!ver}/docker-compose-${comp,,}.yml\""
    eval "${comp}_YML_ALT=\"https://github.com/dappnode/DNP_${comp}/releases/download/v${!ver}/docker-compose.yml\""
    eval "${comp}_ENV=\"https://github.com/dappnode/DNP_${comp}/releases/download/v${!ver}/${comp,,}.dnp.dappnode.eth.env\""
    eval "${comp}_MANIFEST=\"https://github.com/dappnode/DNP_${comp}/releases/download/v${!ver}/dappnode_package.json\""
    eval "${comp}_YML_FILE=\"${DAPPNODE_CORE_DIR}docker-compose-${comp,,}.yml\""
    eval "${comp}_FILE=\"${DAPPNODE_CORE_DIR}${comp,,}.dnp.dappnode.eth_${!ver##*:}.tar.xz\""
    eval "${comp}_ENV_FILE=\"${DAPPNODE_CORE_DIR}${comp,,}.dnp.dappnode.eth.env\""
    eval "${comp}_MANIFEST_FILE=\"${DAPPNODE_CORE_DIR}dappnode_package-${comp,,}.json\""
done

dappnode_core_download()
{
    for comp in "${components[@]}"; do
        ver="${comp}_VERSION"
        if [[ ${!ver} != dev:* ]]; then
            # Download DAppNode Core docker-compose yml files if it's needed
            eval "echo Downloading \$${comp}_YML"
            eval "[ -f \$${comp}_YML_FILE ] || $WGET -O \$${comp}_YML_FILE \$${comp}_YML"
            eval "echo Downloading alternative \$${comp}_YML_ALT"
            eval "[ -f \$${comp}_YML_FILE ] || $WGET -O \$${comp}_YML_FILE \$${comp}_YML_ALT"
            # Download DAppNode Core env files if it's needed
            eval "echo Downloading \$${comp}_ENV"
            eval "[ -f \$${comp}_ENV_FILE ] || $WGET -O/dev/null -q \$${comp}_ENV 2>&1 >/dev/null && $WGET -O \$${comp}_ENV_FILE \$${comp}_ENV 2>&1 >/dev/null" 
            # Create DAppNode Core empty env files if missing
            eval "[ -f \$${comp}_ENV_FILE ] || touch \$${comp}_ENV_FILE"
            # Download DAppNode Core env files if it's needed
            eval "echo Downloading \$${comp}_MANIFEST"
            eval "[ -f \$${comp}_MANIFEST_FILE ] || $WGET -O \$${comp}_MANIFEST_FILE \$${comp}_MANIFEST"
            # Download DAppNode Core Images if it's needed
            eval "echo Downloading \$${comp}_URL"
            eval "[ -f \$${comp}_FILE ] || $WGET -O \$${comp}_FILE \$${comp}_URL"

            echo "---DOWNLOADED---"
            ls -l $DAPPNODE_CORE_DIR
            echo "----------------"            
            echo "----------------"            
            echo "----------------"            

        fi
    done
}

echo -e "\e[32mDownloading DAppNode Core...\e[0m"
dappnode_core_download

