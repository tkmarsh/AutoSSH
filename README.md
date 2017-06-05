# PiConnect
A simple bash script to automatically ssh into your Raspberry Pi or any other device, using one of two methods.

Standard method checks the ARP cache for an IP associated with the devices MAC address.

Root method uses Nmap to scan all devices on local network to find the IP associated with the provided MAC address.

```
Executing with no flags runs the script with the default values.

-m is used to specify a MAC address.

-l is used to specify a username for login.

-n is used to search for the IP using Nmap (Requires root).
```

-n is slower and requies root to run, but is needed if the ARP cache doesn't contain the IP.


Designed for Debian, so results may vary between distros.

Sudo is required to run the nmap scan.

`chmod +x` and `cp`/`mv` the script into `/usr/bin` for easy access.

You can find the MAC address of the devices ethernet and wifi interfaces by running `ifconfig` and checking the HWaddr field.

