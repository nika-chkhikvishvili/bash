#!/bin/sh
# Smart Kiosk Interactive Shell
# by Nick Chkhikvisvili 
# SmartLogic - 2016



source ./smart-kiosk.conf


read -p "Enter MAC address: " mac_raw

# sourcing mac-correcter
echo executing mac-correcter script....
. ./smart-kiosk-mac-correcter.sh 


#sourcing dhcpd
echo executing dhcpd script....
. ./smart-kiosk-dhcpd.sh


#sourcing named
echo executing named script...
. ./smart-kiosk-named.sh
