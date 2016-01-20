#!/bin/sh
# Smart Kiosk Interactive Shell
# by Nick Chkhikvisvili 
# SmartLogic - 2016



source /etc/smart-kiosk/smart-kiosk.conf


read -p "Enter MAC address: " mac_raw

# sourcing mac-correcter
. /$bin_dir/smart-kiosk-mac-correcter.sh 


#sourcing dhcpd
. /$bin_dir/smart-kiosk-dhcpd.sh


#sourcing named
. /$bin_dir/smart-kiosk-named.sh


