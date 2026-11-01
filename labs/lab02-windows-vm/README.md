# Lab 2 — A Windows guest, and a network between them

Pair: Mikhail Martsinovskiy
Machine: <Lenovo laptop, Windows 11, 32 GB RAM, 16 CPU cores> guests Ubuntu Server + Windows 11 Enterprise eval
Date: <01.11.2026>

## What I did
1. Downloaded Windows 11 Enterprise evaluation. Licence: <Evaluation Center link>
2. Created lab02-windows: 4 vCPU, 4 GB, 64 GB thin, UEFI + Secure Boot, vTPM.
3. Network mode: <NAT Network>, both guests. Why:  it allows both VMs to communicate with each other and access the internet through the same virtual network.
4. Ping Ubuntu → Windows timed out because Windows Firewall blocked incoming ICMPv4 echo requests. Fixed with: New-NetFirewallRule -DisplayName "Allow ping in (ICMPv4)" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow
5. Overcommitment: set <20> GB + <20> GB on a <32> GB host.

## Network diagram
                  Internet
                     |
              Host Windows 11
                  32 GB RAM
                     |
          VirtualBox NAT Network
                  Lab2-NAT
                 /       \
                /         \
          Ubuntu VM     Windows VM
          10.0.2.4       10.0.2.5

## Result
Metric	        Before	            After
Host RAM in use	 11.7 GB	    26.8 GB
Available RAM	 19.6 GB	    4.4 GB
Committed memory 16.3 / 36.3 GB	    57.5 / 58.3 GB
Cached memory	 9.0 GB	            3.6 GB
What I noticed
After memory overcommitment, host RAM usage increased from 11.7 GB to 26.8 GB.
Available memory decreased from 19.6 GB to 4.4 GB.
Small performance drops while loading browser tabs, youtube videos freeze
## What did not work the first time
Initially, Ubuntu could not successfully ping Windows because incoming ICMP requests were blocked by Windows Firewall.

I added an inbound ICMPv4 firewall rule using PowerShell.

After configuring the firewall, ping worked in both directions.

All four network tests eventually completed with 0% packet loss.

## Evidence
- [evidence/ipconfig-windows.txt](evidence/ipconfig-windows.txt) — Windows address
- [evidence/ip-addr-linux.txt](evidence/ip-addr-linux.txt) — Ubuntu address
- [evidence/ping-both-ways.txt](evidence/ping-both-ways.txt) — both directions and the internet
- [evidence/host-memory-before.png](evidence/host-memory-before.png) — host memory, guests off
- [evidence/host-memory-after.png](evidence/host-memory-after.png) — host memory, both guests overcommitted