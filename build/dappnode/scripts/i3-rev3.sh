if test -z "`lspci | grep \"BCM4313\"`"
then
  	echo "no AVADO i3 detected"
 exit
fi
echo "AVADO i3 detected"


 while test -z "`dmesg | grep \"direct-loading firmware brcm/bcm43xx_hdr-0.fw\"`"
 do
 #    sudo apt-get update
 #    sudo apt-get upgrade
     sudo apt-get install -y firmware-brcm80211

 	echo "polling WiFi driver"   
     /usr/sbin/rmmod brcmsmac
     sleep 1
     /usr/sbin/modprobe -v brcmsmac 
 	sleep 3
 	ip link set wlan0 up
	ip link set wlp2s0b1 up
 	sleep 1 
 done
 echo "OK - WiFi driver Loaded"
