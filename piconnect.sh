#!/bin/bash
 
#Enter default Pi details here
#These are used if no flags are supplied
username="[default login]"
mac="[default device MAC address]"

while getopts ":m:l:n" opt; do
  case $opt in
    m)
      if [[ $OPTARG =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]]; then
       	 echo "Valid MAC."
       	 mac=$OPTARG
       else
       	 echo "Error: Invalid MAC Address."
         echo -e "Usage:\n [-m (Mac Address) | specify Mac address] [-l (login) | specify login] [-n |Nmap scan]
       	 exit 1
        fi
      ;;
    
    l)
      username=$OPTARG
      ;;
      
    n)
     if sudo -n true 2>/dev/null; then 
       echo -e "Scanning for IP via Nmap.\nPlease wait..."
     else
       echo "Scanning for IP via Nmap requires root, please enter your password:"
       sudo -v
       echo "Please wait..."
     fi

    	localip=$(/sbin/ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}' | grep -E -o "([0-9]{1,3}[\.]){2}[0-9]{1,3}.")"*"
    	ip=$(sudo nmap -sP -n $localip | grep -i -B 2 7c:dd:90:b1:00:83 |  grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
    	if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}+$ ]]; then
  	   echo "Successfully found IP via Nmap scan."
 	   ssh="ssh "$ip" -l "$username
 	   echo "Connecting to Raspberry Pi via ssh at" $ip "as" $username"."
 	   eval $ssh
	else
  	   echo "Error: Failed to find host, may be offline."
  	   exit 3
	fi
    	
    	exit 0
    	;;
      
    \?)
      echo "Invalid option: -$OPTARG"
      echo -e "Usage:\n [-m (Mac Address) | specify Mac address] [-l (login) | specify login] [-n |Nmap scan]"
      exit 2
      ;;
  esac
done

ip=$(ip neighbour | grep $mac | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Successfully found IP."
  ssh="ssh "$ip" -l "$username
  echo "Connecting to Raspberry Pi via ssh at" $ip "as" $username"."
 eval $ssh
else
  echo -e "Error: Failed to find host, may be offline."
  exit 3
fi
