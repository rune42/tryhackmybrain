# Networking Commands Cheatsheet: net-tools vs. iproute2

A quick-reference guide for bridging legacy networking commands with modern `ip` replacements.

---

## 1. Check Network Interface Status

| Task | Deprecated Command (`net-tools`) | Modern Replacement (`iproute2`) |
| :--- | :--- | :--- |
| **List active interfaces** | `ifconfig` | `ip link show` *(or `ip l`)* |
| **List all interfaces (up/down)** | `ifconfig -a` | `ip link` |
| **Get short, clean summary** | *N/A (Requires parsing)* | `ip -br link` *(or `ip -br a`)* |
| **Show interface statistics** | `ifconfig eth0` *(look at RX/TX packets)* | `ip -s link show eth0` |

---

## 2. Tweak Network Routes

| Task | Deprecated Command (`net-tools`) | Modern Replacement (`iproute2`) |
| :--- | :--- | :--- |
| **View routing table** | `route -n` *(or `netstat -rn`)* | `ip route` *(or `ip r`)* |
| **Add default gateway** | `route add default gw 192.168.1.1` | `ip route add default via 192.168.1.1` |
| **Delete default gateway** | `route del default gw 192.168.1.1` | `ip route del default` |
| **Add static route** | `route add -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.1.1` | `ip route add 10.0.0.0/8 via 192.168.1.1` |
| **Delete static route** | `route del -net 10.0.0.0 netmask 255.0.0.0` | `ip route del 10.0.0.0/8` |

---

## 3. Identify MAC Addresses

| Task | Deprecated Command (`net-tools`) | Modern Replacement (`iproute2`) |
| :--- | :--- | :--- |
| **View local MAC address** | `ifconfig eth0` *(look for `HWaddr` or `ether`)* | `ip link show eth0` *(look for `link/ether`)* |
| **View neighbor MACs (ARP)** | `arp -n` *(or `arp -a`)* | `ip neighbor` *(or `ip n`)* |
| **Delete neighbor entry** | `arp -d 192.168.1.50` | `ip neighbor del 192.168.1.50 dev eth0` |

---

## 4. Manage VLANs (802.1q)

*Note: Legacy VLAN management relied on the separate `vconfig` tool, which is completely obsolete. The modern `ip link` tool handles VLANs natively.*

| Task | Legacy Command (`vconfig` / `ifconfig`) | Modern Replacement (`iproute2`) |
| :--- | :--- | :--- |
| **Create VLAN interface** | `vconfig add eth0 10` | `ip link add link eth0 name eth0.10 type vlan id 10` |
| **Assign IP to VLAN** | `ifconfig eth0.10 192.168.10.5 netmask 255.255.255.0` | `ip addr add 192.168.10.5/24 dev eth0.10` |
| **Bring VLAN up** | `ifconfig eth0.10 up` | `ip link set dev eth0.10 up` |
| **Remove VLAN interface** | `vconfig rem eth0.10` | `ip link delete eth0.10` |
---
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repo is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
