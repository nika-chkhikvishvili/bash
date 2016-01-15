#!/bin/sh


# check validate and correct ipv4 mac address
# by Nick Chkhikvisvili 
# SmartLogic - 2016
# smart kiosk

# get config file
dhcpd_conf="dhcpd.conf"


#get current station number
current_station=$(cat $dhcpd_conf | grep \#kiosk-station- |sed -e 's/#kiosk-station-//g' | tail -1)
new_station=$((current_station+1))
last_ip_addr=$(cat $dhcpd_conf| grep \fixed-address |sed -e 's/fixed-address //g' -e  's/[[:space:]]//g' -e 's/;//g'| tail -1)
new_ip_addr=$(echo $last_ip_addr | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')


# template
template="
#kiosk-station-$new_station
        host kiosk-station-$new_station.int.archives.gov.ge {
                hardware ethernet $mac_address;
                fixed-address $new_ip_addr;
                option host-name "kiosk-station-$new_station.int.archives.gov.ge";
                max-lease-time 1;
                default-lease-time 300;
                deny unknown-clients;
                }
"

# push changes
cat <<EOF >> $dhcpd_conf
$template
EOF

# reload service
systemctl restart dhcpd.service

exit 0
