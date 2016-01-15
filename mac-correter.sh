#!/bin/sh

# check validate and correct ipv4 mac address
# by Nick Chkhikvisvili 
# SmartLogic - 2016


read -p "Enter MAC address: " mac_raw

# if mac contains ":" and lengt equals 17 then validate.
if [[ $mac_raw == *[:]* ]]
then
   # "MAC Contans :" 
   # check MAC using regex:
   if [[ $mac_raw =~ ^([a-fA-F0-9]{2}:){5}[a-zA-Z0-9]{2}$ ]] && [[ ${#mac_raw} -eq 17 ]];
   then 
         # valid
         mac_address=$(echo "$mac_raw" | tr [:upper:] [:lower:])
   else 
         # invalid
         echo "1 Entered MAC adrress is invalid: $mac_raw"
         exit 1;
   fi
fi 
    #MAC Without ":" validate characters
    if  [[ $mac_raw =~ [^[:digit:][:alpha:]] ]] && [[ ${#mac_raw} -eq 12 ]];
     then 
         # valid and set format
         mac_address=$( echo $mac_raw | sed 's/.\{2\}/&:/g' | tr [:upper:] [:lower:])

fi


echo MAC address: $mac_address

