#!/bin/bash
#Enter your Pi's details here
Username="pi"
MAC="7c:dd:90:b1:00:83"

IP=$(ip neighbor | grep $MAC | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
ssh="ssh "$IP" -l "$Username
echo "Connecting to Raspberry Pi via ssh at" $IP
eval $ssh


