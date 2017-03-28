#!/bin/bash
 
#Enter default Pi details here
#These are used if no flags are supplied
username="[login]"
mac="[device MAC address]"


while getopts ":m:l:n" opt; do
  case $opt in
    m)
      if [[ $OPTARG =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]]; then
       	 echo "Valid MAC."
       	 mac=$OPTARG
       else
       	 echo "Error: Invalid MAC Address."
       	 echo -e "Usage:\n [-m | Mac Address] [-l | login] [-n nmap scan for IP]"
       	 exit 1
        fi
      ;;
    
    l)
      username=$OPTARG
      ;;
      
    n)
    	echo "Scanning for IP via Nmap requires root, please enter your password:"
    	ip=$(sudo nmap -sP -n 100.75.151.* | grep -i -B 2 7c:dd:90:b1:00:83 |  grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
    	echo $ip
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
      echo -e "Usage:\n [-m | Mac Address] [-l | login]"
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
