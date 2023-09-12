# @TEST-DOC: Test Zeek parsing a trace file through the DHCPV6 analyzer.
#
# @TEST-EXEC: zeek -Cr ${TRACES}/udp-port-12345.pcap ${PACKAGE} %INPUT >output
# @TEST-EXEC: btest-diff output
# @TEST-EXEC: btest-diff dhcpv6.log

# TODO: Adapt as suitable. The example only checks the output of the event
# handlers.

event DHCPV6::message(c: connection, is_orig: bool, payload: string)
    {
    print fmt("Testing DHCPV6: [%s] %s %s", (is_orig ? "request" : "reply"), c$id, payload);
    }
