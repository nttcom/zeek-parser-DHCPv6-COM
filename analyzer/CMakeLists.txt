spicy_add_analyzer(
    NAME DHCPV6
    PACKAGE_NAME zeek-parser-DHCPV6
    SOURCES dhcpv6.spicy dhcpv6.evt zeek_dhcpv6.spicy
    SCRIPTS __load__.zeek main.zeek dpd.sig
)
