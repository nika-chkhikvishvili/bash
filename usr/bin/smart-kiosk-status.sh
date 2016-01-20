#!/bin/sh
# Smart kiosk script execution report
# by Nika Chkhikvishvili 
# SmartLogic 2016



service=$1
state=$2
message=$3
report=$@


if [[ $state == "ok" ]]; 
 then
    state_msg=`echo -e "\033[1m[\033[0m \033[32;1m  OK  \033[0m \033[1m]\033[0m"`

elif [[ $state == "failed" ]]; 
 then    
    state_msg=`echo -e "\033[1m[\033[0m\033[31;1m FAILED \033[0m\033[1m]\033[0m"`
elif [[ $state == "warn" ]];
 then  
    state_msg=`echo -e "\033[1m[\033[0m \033[33;1m  WARNING  \033[0m \033[1m]\033[0m"`
fi


echo "-----------------"
echo -e "$service config ---> $state_msg\n $message"



# function report
report() {
echo " "
echo "============================================="
echo "Mac Address: $mac_address"
echo "IP Address: $new_ip_addr"
echo "Hostname: $station_prefix$new_station.$domain"
}


if [[ "$report" == *"report"* ]];
 then
    report
fi









