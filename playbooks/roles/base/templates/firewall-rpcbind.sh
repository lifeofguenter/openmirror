#!/usr/bin/env bash
#
# drop all external nfs/rpcbind packets
#

ranges=( '127.0.0.0/8' '10.0.0.0/8' '172.16.0.0/12' '192.168.0.0/16' )

# accept ranges
for range in "${ranges[@]}"; do
  # tcp
  if ! /sbin/iptables -C INPUT -p tcp -s "${range}" --dport 111 -j ACCEPT &> /dev/null; then
    /sbin/iptables -A INPUT -p tcp -s "${range}" --dport 111 -j ACCEPT
  fi
  # udp
  if ! /sbin/iptables -C INPUT -p udp -s "${range}" --dport 111 -j ACCEPT &> /dev/null; then
    /sbin/iptables -A INPUT -p udp -s "${range}" --dport 111 -j ACCEPT
  fi
done

# drop everything else
# tcp
if ! /sbin/iptables -C INPUT -p tcp --dport 111 -j DROP &> /dev/null; then
  /sbin/iptables -A INPUT -p tcp --dport 111 -j DROP
fi
# udp
if ! /sbin/iptables -C INPUT -p udp --dport 111 -j DROP &> /dev/null; then
  /sbin/iptables -A INPUT -p udp --dport 111 -j DROP
fi
