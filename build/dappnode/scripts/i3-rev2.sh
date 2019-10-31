if test -z "`lspci | grep \"BCM43225\"`"
then
  	echo "no AVADO i3 detected"
 exit
fi
echo "AVADO i3 detected"

#apt-get update && apt-get install firmware-brcm80211

while test -z "`dmesg | grep \"direct-loading firmware b43/ucode16_mimo.fw\"`"
do
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install -y b43-fwcutter firmware-b43-installer
	echo "polling WiFi driver"   
    /usr/sbin/rmmod brcmsmac
    /usr/sbin/rmmod b43
    sleep 1
    /usr/sbin/modprobe b43 allhwsupport=1
	sleep 1
	ip link set wlan0 up
	sleep 5 
done
echo "OK - WiFi driver Loaded"
