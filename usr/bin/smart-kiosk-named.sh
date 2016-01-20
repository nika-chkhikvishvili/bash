#!/bin/sh



# get currenty serial
zone_old_serial=$(cat $named_zone_file |awk NR==3 | sed  -e  's/[[:space:]]//g')
zone_new_serial=$(($zone_old_serial + 1))
rev_old_serial=$(cat $named_rev_file |awk NR==3 | sed  -e  's/[[:space:]]//g')
rev_new_serial=$(($rev_old_serial + 1))
reverse_ip_addr=$(echo $new_ip_addr | awk 'BEGIN{FS="."}{print $4"."$3"."$2"."$1}')





# increase zone serail 
sed -i "s/$zone_old_serial/$zone_new_serial/g" $named_zone_file

# add A RR
echo "$station_prefix$new_station.$domain   IN      A       $new_ip_addr" >>$named_zone_file


# increase rev serial
sed -i "s/$rev_old_serial/$rev_new_serial/g" $named_rev_file


# add PTR RR
$reverse_ip_addr.in-addr.arpa.       IN      PTR     $station_prefix$new_station.$domain." >>$named_rev_file



# reload zone
rndc reload

