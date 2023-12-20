#!/usr/bin/env pwsh
# Script:                       Create script to set a static IP and DNS Server
# Author:                       Yue Moua
# Date of latest revision:      12/20/2023
# Purpose:                      Powershell AD automation


# Define parameters
$NetworkAdapterName = "Ethernet"  # Replace with the name of your network adapter
$StaticIPAddress = "192.168.1.10"   # Replace with your desired static IP address
$SubnetMask = "255.255.255.0"       # Replace with your subnet mask
$DefaultGateway = "192.168.1.1"      # Replace with your default gateway
$PreferredDNS = "8.8.8.8"            # Replace with your preferred DNS server
$AlternateDNS = "8.8.4.4"            # Replace with your alternate DNS server

# Set static IPv4 address using Netsh
netsh interface ipv4 set address name=$NetworkAdapterName static $StaticIPAddress $SubnetMask $DefaultGateway

# Set DNS server addresses using Set-DnsClientServerAddress
Set-DnsClientServerAddress -InterfaceAlias $NetworkAdapterName -ServerAddresses @($PreferredDNS, $AlternateDNS)
