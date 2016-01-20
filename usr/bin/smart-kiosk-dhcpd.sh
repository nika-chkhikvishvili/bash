#!/bin/sh


# check validate and correct ipv4 mac address
# by Nick Chkhikvisvili 
# SmartLogic - 2016
# smart kiosk




# check mac address already exist
for existing_mac in $(cat $dhcpd_conf_file | grep "hardware ethernet" | sed -e 's/hardware ethernet//g' -e 's/;//g');
  do 
     if [ "$existing_mac" == "$mac_address" ];
      then 
         . /$bin_dir/smart-kiosk-status.sh dhcp failed "entered mac: \"$mac_address\" allready exists."
        exit 1
     fi 
done



#get current station number
current_station=$(cat $dhcpd_conf_file | grep \#$station_prefix |sed -e "s/#$station_prefix//g" | tail -1)
new_station=$((current_station+1))
last_ip_addr=$(cat $dhcpd_conf_file| grep \fixed-address |sed -e 's/fixed-address //g' -e  's/[[:space:]]//g' -e 's/;//g'| tail -1)

# check if stations already exists in dhcpd config file
if [[ -z $last_ip_addr ]]; 
 then 
    #echo setting ip address from config
    new_ip_addr=$start_ip_addr
else 
    new_ip_addr=$(echo $last_ip_addr | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
fi




# template
template="
#$station_prefix$new_station
        host $station_prefix$new_station.$domain {
                hardware ethernet $mac_address;
                fixed-address $new_ip_addr;
                option host-name \"$station_prefix$new_station.$domain\";
                max-lease-time 1;
                default-lease-time 300;
                deny unknown-clients;
                }
"



# push changes
cat <<EOF >> $dhcpd_conf_file
$template
EOF

# reload service
systemctl restart dhcpd.service
if [[ $? -ne 0 ]]; 
then 
. /$bin_dir/smart-kiosk-status.sh dhcp failed "cannot apply changes to dhcp"
    exit 1;
fi

. /$bin_dir/smart-kiosk-status.sh dhcp ok 



