#!/bin/sh
# Smart Kiosk Interactive Shell
# by Nick Chkhikvisvili 
# SmartLogic - 2016



#source /smartkiosk/smart-kiosk.conf
source etc/smart-kiosk/smart-kiosk.conf


read -p "Enter MAC address: " mac_raw

# sourcing mac-correcter
echo executing mac-correcter script....
. /$bin_dir/smart-kiosk-mac-correcter.sh 


#sourcing dhcpd
echo executing dhcpd script....
. /$bin_dir/smart-kiosk-dhcpd.sh


#sourcing named
echo executing named script...
. /$bin_dir/smart-kiosk-named.sh
