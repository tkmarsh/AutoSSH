# PiConnect
A simple bash script to automatically ssh into your Raspberry Pi or any other device, using two methods.

Standard method checks the ARP cache for an IP associated with the devices MAC address.
Root method uses Nmap to scan all devices on local network to find the IP associated with the MAC.

Executing with no flags runs the script with the default values.
-m is used to specify a MAC address.
-l is used to specify a username for login.
-n is used to search for the IP using Nmap (Requires root).

Chmod +x and cp/mv the script into /usr/bin for easy access.

