# Lab 1 — Your first virtual machine

Pair: Mikhail                    Driver first half:Mikhail
Machine:Lenovo laptop, Guest: Ubuntu Server 26.04.1 LTS
Date:25.10.2026

## What I did

1. Installed VirtualBox 7.x hypervisor.
2. Created VM lab01-ubuntu: 2 vCPU, 4 GB RAM, 25 GB dynamic disk, NAT network mode.
3. Installed Ubuntu Server, took snapshot "clean-install".
4. Broke it: ran sudo rm /etc/hostname to delete the system hostname configuration file.
5. Rolled back to clean-install: used VirtualBox Snapshot Restore feature to completely revert the damage.

## Resource justification

I allocated 2 vCPU cores and 4 GB of RAM because it is fully sufficient for running a headless Ubuntu Server without a graphical user interface. Since my host machine has a 32-core CPU, allocating 2 cores leaves plenty of resources for Windows to run smoothly

## Result
The VM boots; the break-and-rollback cycle is shown in the evidence below.

## What did not work the first time
During the first git push attempt, the command was rejected because the local repository was out of sync with the remote GitHub repository. To fix this, I successfully ran git pull origin main to fetch and merge remote changes, resolved the automatic merge message configuration, and then successfully executed git push.


## Evidence
- [evidence/vm-settings.png](evidence/vm-settings.png) — CPU, memory and disk as configured
- [evidence/guest-release.txt](evidence/guest-release.txt) — Ubuntu Server is running in the guest
- [evidence/broken.png](evidence/broken.png) — the guest in its broken state
- [evidence/snapshot-list.png](evidence/snapshot-list.png) — the snapshot, after the rollback