# Zeek-Parser-DHCPv6-COM

## Overview

Zeek-Parser-DHCPv6-COM is a Zeek plug-in that can analyze communication using DHCPv6(Dynamic Host Configuration Protocol for IPv6).

## Installation

### Installation with Package Manager

This plug-in is provided as a package for [Zeek Package Manger](https://docs.zeek.org/projects/package-manager/en/stable/index.html).

It can be installed by executing the commands below.

```
zkg refresh
zkg install zeek-parser-DHCPv6-COM
```

### Manual Installation

Before using this plug-in, please make sure Zeek, Spicy has been installed.

````
# Check Zeek
~$ zeek -version
zeek version 5.0.0

# Check Spicy
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# As a premise, the path of zeek in this manual is as below
~$ which zeek
/usr/local/zeek/bin/zeek
````

Use `git clone` to get a copy of this repository to your local environment.
```
~$ git clone https://github.com/nttcom/zeek-parser-DHCPV6-COM.git
```

## Usage

### For installation using a package manager

`dhcpv6.log` will be generated by the command below:

```
zeek -Cr /usr/local/zeek/var/lib/zkg/clones/package/zeek-parser-DHCPv6-COM/testing/Traces/test.pcap zeek-parser-DHCPv6-COM
```

### For manual installation

Compile source code and copy the object files to the following path.
```
~$ cd ~/zeek-parser-DHCPV6-COM/analyzer
~$ spicyz -o dhcpv6.hlto dhcpv6.spicy zeek_dhcpv6.spicy dhcpv6.evt 
# dhcpv6.hlto will be generated
~$ cp dhcpv6.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

Then, copy the zeek file to the following paths.
```
~$ cd ~/zeek-parser-DHCPV6-COM/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/DHCPV6.zeek
```

Finally, import the Zeek plugin.
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
... Omit ...
@load DHCPV6
```

This plug-in generates a `dhcpv6.log` by the command below:
```
~$ cd ~/zeek-parser-DHCPV6-COM/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/DHCPV6.zeek
```

## Log type and description
This plug-in monitors all functions of dhcpv6 and outputs them as `dhcpv6.log`.

| Field | Type | Description |
| --- | --- | --- |
| ts | time | timestamp of the communication |
| SrcIP | addr | source IP address  |
| SrcMAC | string | source MAC address |
| Hostname | string | name of the host |
| FingerPrint | vector[count] | Identifier of a particular computer, server, virtual machine, system, application, tool or environment |
| EnterpriseNumber | count | Number of occurrences of a company or organization's identification number |
| VendorClass | string | Vendor-provided client software, device type and version information |

An example of `dhcpv6.log` is as follows:
```
#separator \x09
#set_separator	,
#empty_field	(empty)
#unset_field	-
#path	dhcpv6
#open	2023-09-13-05-06-45
#fields	ts	SrcIP	SrcMAC	Hostname	FingerPrint	EnterpriseNumber	VendorClass
#types	time	addr	string	string	vector[count]	count	string
1547129924.510607	fe80::8882:5cf6:f2eb:c8b9	00:0c:29:71:12:2e	vagrant-2008R2happycrazy	311,24,23,17,39	311	MSFT 5.0
1547129962.336912	fe80::28e4:bf15:6f67:5024	00:0c:29:c2:25:f9	WIN7-CLIENT-01happycrazy	311,24,23,17,39	311	MSFT 5.0
1547129987.504802	fe80::8882:5cf6:f2eb:c8b9	00:0c:29:71:12:2e	vagrant-2008R2happycrazy	311,24,23,17,39	311	MSFT 5.0
#close	2023-09-13-05-06-45
```

## Related Software

This plug-in is used by [OsecT](https://github.com/nttcom/OsecT).


