# Ticket 1 — New developer starts Monday, needs a test machine

## 1. What was asked

> **From:** Aigerim T. (Office Manager)  
> **Subject:** test machine for new dev  
>  
> Hi, we have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself? Thanks

## 2. What was actually needed

The real need was not simply a spare computer. The developer needs a repeatable test environment where he can install software, change settings, and make mistakes without changing the host computer. The environment also needs a reliable way to return to a known state.

The request leaves out important technical details:

- **Operating systems:** the email says “a test computer” in the singular and does not name any operating system. The assignment requires two guests, so I used Ubuntu Server and Windows 11 Enterprise Evaluation.
- **Developer workload:** the request does not say which languages, tools, or applications the developer will test. I assumed that a command-line Linux server and a Windows 11 environment are suitable general test systems. Ubuntu Server has no desktop interface by default. If the developer needs a Linux desktop or GUI applications, I would ask whether Ubuntu Desktop is required.
- **Meaning of “without breaking anything”:** a VM keeps its guest operating system and virtual disk separate from the host in normal use. However, it is not a perfect security boundary. Shared folders, shared clipboard, drag-and-drop, USB passthrough, bridged networking, and access to network services can create paths between the guest, host, and other systems. I would leave these integrations disabled unless the developer has a clear need for them.
- **Recovery:** a clean snapshot gives the developer a known rollback point. Restoring it removes changes made to the guest since that snapshot. A snapshot is not a backup and does not undo actions already taken on other systems or files written outside the VM.
- **Host resources:** the request gives no hardware information. I used the Lab 0 host figures: Windows 11, 32 GB RAM, 16 CPU processors as recorded in Lab 0, and two approximately 1 TB drives. Drive C: has 936,747,548,672 bytes free; Drive D: has 1,024,068,804,608 bytes free.
- **Networking:** the request does not say whether the guests need internet access or need to communicate with each other. I assumed both are required for development and testing. I used one shared NAT Network for both guests.
- **Licensing:** the request does not specify whether this is a short evaluation or a permanent work environment. I used the free VirtualBox base package, Ubuntu Server LTS, and the official Windows 11 Enterprise Evaluation image. The Windows Enterprise Evaluation is a 90-day evaluation and is not a permanent production licence. Aigerim should arrange an appropriate Windows licence if the VM will be kept for ongoing business use after the evaluation period.
- **Reader:** Aigerim is an office manager, not a hypervisor administrator. The build guide therefore explains the interface, gives one action at a time, and includes checks after important steps.

### Questions I would ask Aigerim

1. Which development tools, programming languages, and applications will the new developer use?
2. Does he need both Linux and Windows, and does Linux need a graphical desktop?
3. Do the guests need internet access only, or must they also reach office computers, printers, or internal servers?
4. Does he need shared folders, clipboard sharing, USB devices, or persistent files outside the VM?
5. Is this a temporary evaluation environment, or will it be used as a permanent business workstation? Who will provide the Windows licence after evaluation?
6. How much host memory, CPU capacity, and free disk space are available on the actual office computer?

### Assumptions made instead of answers

I assumed the supplied Lab 0 computer is the host for this build; the required guests are Ubuntu Server and Windows 11 Enterprise; both guests need internet access and communication with each other; the test data can be reset from snapshots; and no shared folders, USB passthrough, or clipboard sharing are needed by default. I also assumed that the Windows VM is for temporary evaluation only.

### Host resource calculation

| Host resource | Lab 0 value | How it affects the build |
|---|---:|---|
| RAM | 32 GB | 4,090 MB for each VM uses about 8 GB in total and leaves about 24 GB for the host while both VMs are running. |
| CPU | 16 CPU processors (Lab 0 figure) | Ubuntu uses 2 virtual CPUs and Windows uses 4, for 6 virtual CPUs in total. |
| Drive C: free | 936,747,548,672 bytes (about 936.7 GB) | More than enough free space, but it is also the Windows system drive. |
| Drive D: free | 1,024,068,804,608 bytes (about 1,024.1 GB) | A suitable location for VM files if the office wants to keep them separate from the host OS. |
| Maximum virtual disk capacity | 25 GB + 64 GB = 89 GB | This is the combined maximum capacity before snapshot growth. Dynamic disks grow as data is written, so they do not occupy the full maximum size immediately. |

The resource allocation is modest compared with the host: the two guests are allocated approximately 8 GB of the host's 32 GB RAM. The 89 GB combined virtual disk capacity is also small compared with the free space on either host drive. Snapshot files can grow over time, so free disk space still needs to be monitored.

### Settings changed from the initial VirtualBox configuration

| Setting | Initial/default position | Actual configuration | Reason |
|---|---|---|---|
| Ubuntu RAM | VirtualBox suggests a value based on the selected guest OS; the exact suggested value was not recorded | 4,090 MB | Enough for the selected server workload while keeping host memory available. |
| Ubuntu CPUs | Wizard suggestion; exact value not recorded | 2 | A small server workload does not need many virtual CPUs. |
| Ubuntu virtual disk | Wizard suggestion; exact size not recorded | 25 GB, dynamically allocated | Enough for a basic server test image without reserving a large fixed file. |
| Windows RAM | VirtualBox suggests a value based on the selected guest OS; the exact suggested value was not recorded | 4,090 MB | Meets the approximate 4 GB baseline used for this evaluation VM while leaving RAM for the host. |
| Windows CPUs | Wizard suggestion; exact value not recorded | 4 | More CPU capacity for the Windows guest and developer tools. |
| Windows virtual disk | Wizard suggestion; exact size not recorded | 64 GB, dynamically allocated | Matches the minimum Windows 11 storage baseline; it may be tight for a larger development toolchain. |
| Windows firmware | UEFI option is not selected in the basic creation flow by default | UEFI enabled | Windows 11 requires UEFI firmware with Secure Boot capability. |
| Windows Secure Boot | Disabled unless enabled in VM settings | Enabled | Meets the Windows 11 Secure Boot requirement. |
| Windows TPM | No TPM device / TPM disabled by default | TPM 2.0 | Meets the Windows 11 TPM 2.0 requirement. |
| Network adapter | VirtualBox's standard new-VM setting is NAT | NAT Network on both guests | Standard NAT gives internet access but does not provide direct guest-to-guest communication. NAT Network supports both guest-to-guest and guest-to-internet traffic. |
| Virtual disk allocation | Dynamically allocated disk in the basic wizard | Dynamic on both guests | The disk files grow as data is written instead of reserving the maximum capacity immediately. |

The exact wizard-suggested RAM, CPU, and disk-size values were not saved during Lab 1 and Lab 2. I have not invented those numbers. The table records the actual settings and explains the reason for each manual choice.

## 3. What I did

1. Checked the host resources in Lab 0: Windows 11, 32 GB RAM, 16 CPU processors/threads, and the free space on drives C: and D:.
2. Used Oracle VirtualBox 7.2 as the hypervisor. The base package is available under GPLv3. I did not need the separately licensed Extension Pack for this basic two-VM setup.
3. Installed Ubuntu Server 26.04.1 LTS (64-bit) as the Linux guest. The guest reports kernel `7.0.0-38-generic` and architecture `x86_64`.
4. Installed Windows 11 Enterprise Evaluation from Microsoft's Evaluation Center. This is a 90-day evaluation image, not a permanent Windows licence.
5. Configured Ubuntu with 4,090 MB RAM, 2 virtual CPUs, and a 25 GB dynamically allocated virtual disk.
6. Configured Windows with 4,090 MB RAM, 4 virtual CPUs, and a 64 GB dynamically allocated virtual disk. I enabled UEFI, Secure Boot, and TPM 2.0 for Windows 11 compatibility.
7. Connected both guests to the same NAT Network. I chose NAT Network instead of ordinary NAT because the guests need to communicate with each other as well as reach the internet.
8. Tested connectivity in both directions and tested internet access from both guests. All four tests reported zero packet loss.
9. Confirmed that snapshots exist for both guests. Their names and whether they are clean pre-experiment baselines have not yet been documented. Before handing the environment to a developer, I would verify this or create new clean snapshots after installation and required updates.

### Network test results

| Test | Result reported |
|---|---|
| Windows VM to Ubuntu VM (`ping 10.0.2.4`) | Sent 4, received 4, lost 0 |
| Ubuntu VM to Windows VM (`ping -c 4 10.0.2.5`) | 4 transmitted, 4 received, 0% packet loss |
| Ubuntu VM to internet (`ping -c 4 ubuntu.com`) | 4 transmitted, 4 received, 0% packet loss |
| Windows VM to internet (`ping ubuntu.com`) | Sent 4, received 4, lost 0 |

Observed guest addresses during the test were Ubuntu `10.0.2.4` and Windows `10.0.2.5`. These are observed addresses, not guaranteed permanent addresses; check the current address inside each guest before repeating the test.

### Problem encountered and resolution

At first, ping between the guests did not work because Windows Firewall blocked inbound echo requests. I resolved this by adding an inbound Windows Firewall rule to allow ICMPv4 Echo Request traffic from the NAT Network. I did not turn the firewall off. After the rule was added, Windows-to-Ubuntu and Ubuntu-to-Windows ping tests both succeeded with zero packet loss.

## 4. Evidence

The evidence files below must be placed in the `evidence/` folder. The two text files are prepared as drafts; the ping file must be replaced with the complete, unedited terminal output before submission. The four PNG screenshots still need to be captured from the actual VirtualBox/guest windows. Additional step screenshots can be saved in `evidence/screenshots/`.

| Evidence file | What it proves | Status |
|---|---|---|
| [`evidence/01-new-vm-wizard.png`](evidence/01-new-vm-wizard.png) | The New VM wizard and the selected guest/resource choices. | Capture from VirtualBox. |
| [`evidence/02-disk-settings.png`](evidence/02-disk-settings.png) | Disk capacity and dynamically allocated disk type. | Capture from VirtualBox. |
| [`evidence/03-network-adapter.png`](evidence/03-network-adapter.png) | A guest is attached to the shared NAT Network. | Capture from VirtualBox; also verify the other guest uses the same network name. |
| [`evidence/04-guest-uname.txt`](evidence/04-guest-uname.txt) | Ubuntu kernel, architecture, and distribution version. | Draft prepared from the command results supplied. |
| [`evidence/05-ping-between-guests.txt`](evidence/05-ping-between-guests.txt) | Full ping output for both directions and both internet tests. | Replace the marked template with full, unedited output from the actual terminals. |
| [`evidence/06-snapshot-list.png`](evidence/06-snapshot-list.png) | The clean baseline snapshots for both VMs. | Capture from VirtualBox; make sure both guest names and snapshot names are visible. |

## 5. What I would do differently

For the next build, I would ask Aigerim about the developer's actual toolchain and whether a Linux desktop is needed before choosing Ubuntu Server. I would also give the Windows VM more than 64 GB of virtual disk space if the developer needs several IDEs, SDKs, containers, or large projects. Finally, I would name both clean snapshots clearly, record the NAT Network name, and capture full unedited command output during the build instead of reconstructing evidence afterwards.
