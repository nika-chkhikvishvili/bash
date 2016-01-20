#!/bin/sh



# get currenty serial
old_serial=$(cat $named_zone_file |awk NR==3 | sed  -e  's/[[:space:]]//g')
new_serial=$(($old_serial + 1))


# increase zone serail 
sed -i "s/$old_serial/$new_serial/g" $named_zone_file

# add A RR
echo "$station_prefix$new_station.$domain   IN      A       $new_ip_addr" >>$named_zone_file


# reload zone
rndc reload

