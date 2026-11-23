# Lab 3 — Teardown, and the same machine from the command line

Mikhail Martsinovskiy 
CYB26-6
Date:23.11.26

# Part 1 — Ten Components

### 1. AMD Ryzen 5 7600

**Description:** A processor with 6 cores and 12 threads, a 3.8 GHz base frequency and a maximum boost frequency of 5.1 GHz. It has 32 MB of L3 cache and a 65 W TDP.

**Compatibility:** Uses the AM5 socket and supports DDR5 memory only (DDR5-5200 with two DIMMs).

**Limitations:** Compatible only with AM5 motherboards that support DDR5. It cannot work with DDR4 memory or be installed in an LGA1700 motherboard. The processor comes with an AMD Wraith Stealth cooler.

**Source:** https://www.amd.com/ja/products/processors/desktops/ryzen/7000-series/amd-ryzen-5-7600.html

### 2. Intel Core i5-13400

**Description (verify):** A processor with 10 cores (6 P-cores and 4 E-cores) and 16 threads. Its maximum frequency is 4.6 GHz, it has 20 MB of cache and a base power of 65 W.

**Compatibility:** Uses the LGA1700 socket. Its memory controller supports both DDR4 and DDR5, depending on the motherboard.

**Limitations:** Works only with LGA1700 motherboards and is not compatible with AM5. The motherboard determines which memory type can be installed.

**Source:** https://www.intel.com/content/www/us/en/products/sku/230495/intel-core-i513400-processor-20m-cache-up-to-4-60-ghz/specifications.html

### 3. ASUS PRIME B650M-A

**Description:** A Micro-ATX motherboard based on the AMD B650 chipset.

**Compatibility:** Uses the AM5 socket and provides 4 DDR5 DIMM slots with dual-channel support, speeds up to 5600 MT/s with overclocking and AMD EXPO support. It also includes 2 M.2 Key M slots (2242/2260/2280): M.2_1 supports PCIe 5.0 x4 with Ryzen 7000/9000 processors, while M.2_2 supports PCIe 4.0 x4 through the chipset. Additionally, it has 4 SATA 6 Gb/s ports.

**Limitations:** Supports Ryzen 7000, 8000 and 9000 desktop processors using AM5, with a maximum supported power of 170 W. It supports DDR5 memory only. Older BIOS versions may require a BIOS FlashBack update to support newer processors.

**Source:** https://asus.com/motherboards-components/motherboards/prime/prime-b650m-a/techspec

### 4. MSI PRO B760M-A WIFI DDR4

**Description (verify):** A Micro-ATX motherboard equipped with the Intel B760 chipset.

**Compatibility:** Uses the LGA1700 socket, supports DDR4 DIMM memory and provides M.2 and SATA connections — 2.

**Limitations:** Compatible with 12th, 13th and 14th-generation Intel processors only (check the CPU Support list). It accepts DDR4 memory modules only; DDR5 modules cannot fit.

**Source:** https://ru.msi.com/Motherboard/PRO-B760M-A-WIFI-DDR4

### 5. Kingston FURY Beast DDR5-5600, 16 GB

**Description (verify):** A DDR5 DIMM memory module with a 288-pin design, 16 GB capacity and a speed of 5600 MT/s. Its listed voltages are 1.25, 1.35 and 1.4 V. The operating temperature range is 0–85°C.

**Compatibility:** Designed for desktop DDR5 motherboard DIMM slots, with one module installed in a memory slot.

**Limitations:** Works only with DDR5-compatible motherboards. Its notch is positioned differently from DDR4 memory, making it physically incompatible with DDR4 slots. The actual operating speed also depends on the processor's memory controller.

**Source:** https://www.kingston.com/en/memory/gaming/kingston-fury-beast-ddr5-memory?speed=5600mt%2Fs&total%20(kit)%20capacity=16gb&kit=single%20module&cas%20latency=40&dram%20density=16gbit&profile%20type=intel%20xmp&color=black

### 6. Crucial DDR4-3200, 16 GB DIMM

**Description (verify):** A DDR4 UDIMM memory module with 288 pins, 16 GB capacity, a speed of 3200 MT/s and a voltage of 1.2 V.

**Compatibility:** Fits into standard desktop DIMM slots on motherboards that support DDR4.

**Limitations:** Compatible with DDR4 motherboards only. It cannot be installed in a Ryzen 5 7600 / AM5 system because the AM5 platform does not support DDR4 memory.

**Source:** https://www.crucial.com/memory/ddr4/ct16g4dfra32a?srsltid=AYCX9vJNCciK2IA5ecF3g3iWMa1T9sPCf775VGMK2wQIi8cXMY_-M4cT

### 7. Samsung 990 PRO 1 TB

**Description:** An NVMe SSD with an M.2 2280 form factor, PCIe 4.0 x4 interface and NVMe 2.0 support. It offers sequential read speeds of up to 7,450 MB/s and write speeds of up to 6,900 MB/s.

**Compatibility:** Connects directly to an M.2 Key M slot on the motherboard, so SATA data and power cables are not required.

**Limitations:** Requires an M.2 NVMe-compatible slot. To reach PCIe 4.0 speeds, the slot must support PCIe 4.0 x4. The PCIe 5.0 slot on the B650M-A is backward compatible.

**Source:** https://download.semiconductor.samsung.com/resources/data-sheet/Samsung_NVMe_SSD_990_PRO_Datasheet_Rev.1.0.pdf

### 8. Samsung 870 EVO 1 TB

**Description (verify):** A 1 TB SATA III SSD in a 2.5-inch form factor. Its maximum read speed is 560 MB/s, while its maximum write speed is 530 MB/s.

**Compatibility:** Connects to a motherboard SATA port using a SATA data cable and receives power through a SATA power cable from the PSU.

**Limitations:** The SATA interface limits its speed to approximately 550 MB/s, making it roughly 13 times slower than the maximum read speed of the 990 PRO.

**Source:** https://news.samsung.com/kz_ru/samsung_870_evo

### 9. Corsair RM750e (750 W)

**Description (verify):** A 750 W ATX power supply with an 80 PLUS Gold certification, fully modular cables and support for ATX 3.1 / PCIe 5.1.

**Compatibility:** Supplies power to the motherboard through the 24-pin ATX and 8-pin CPU connectors. It also powers storage drives through SATA power cables and the graphics card through PCIe power connectors.

**Limitations:** Its total output is 750 W, which is sufficient for either of the two builds below. However, only one power supply is available, meaning it can be used in only one build.

**Source:** https://www.corsair.com/eu/en/p/psu/cp-9020295-eu/rme-series-rm750e-fully-modular-low-noise-atx-power-supply-eu-cp-9020295-eu

### 10. Stock Cooler — AMD Wraith Stealth

**Description:** The cooling solution included in the box with the Ryzen 5 7600. AMD's official product page identifies the included cooler as the Wraith Stealth.

**Compatibility:** Attaches to the processor's AM5 socket and is mounted using the motherboard's AM5 retention bracket.

**Limitations:** Designed for the 65 W Ryzen 5 7600. Its cooling capacity determines how much heat it can dissipate.

**Source:** https://www.amd.com/ja/products/processors/desktops/ryzen/7000-series/amd-ryzen-5-7600.html

---

# Build 1 — AMD / DDR5 / NVMe

| Part | Model | Why it is compatible |
|---|---|---|
| Processor | AMD Ryzen 5 7600 | Uses AM5, which matches the motherboard socket. |
| Motherboard | ASUS PRIME B650M-A | Has an AM5 socket and a B650 chipset that supports Ryzen 7000 processors. |
| Memory | Kingston FURY Beast DDR5-5600 16 GB | Both the Ryzen 7000 platform and this motherboard support DDR5 only. |
| SSD | Samsung 990 PRO 1 TB | The motherboard has M.2 Key M slots (PCIe 5.0 / 4.0), compatible with this M.2 2280 PCIe 4.0 drive. |
| Power supply | Corsair RM750e | Provides the required 24-pin motherboard and 8-pin CPU connections. Its 750 W capacity is more than sufficient for a 65 W CPU. |
| Cooler | AMD Wraith Stealth | Comes included with the Ryzen 5 7600 and fits the AM5 socket. |

**Still required:** Case, operating system, monitor, keyboard and GPU.

# Build 2 — Intel / DDR4 / SATA

| Part | Model | Why it is compatible |
|---|---|---|
| Processor | Intel Core i5-13400 | Uses the LGA1700 socket, which matches the motherboard. |
| Motherboard | MSI PRO B760M-A WIFI DDR4 | Uses LGA1700 and the B760 chipset, which supports 13th-generation Intel processors (BIOS update may be required). |
| Memory | Crucial DDR4-3200 16 GB | This motherboard has DDR4 memory slots only. |
| SSD | Samsung 870 EVO 1 TB | A 2.5-inch SATA drive that connects to the motherboard's SATA ports using a data cable and a power cable. |

**Still required:** Power supply (the only Corsair RM750e is assigned to Build 1), CPU cooler, case, SATA data cable and operating system.




## Part 2 — The Same Machine from the Command Line

### 1. Windows — PowerShell

Windows was running directly on the physical computer.

| Fact | Result |
|---|---|
| CPU model | AMD Ryzen 9 9955HX |
| Physical cores | 16 |
| Logical processors | 32 |
| Reported maximum clock speed | 2500 MHz |
| Total RAM | 32 GB |
| RAM configuration | 2 × 16 GB |
| RAM type | DDR5 |
| RAM speed | 5600 MT/s |
| SSD model | Samsung MZAL81T0HFLB-00BL2 |
| Disk interface | NVMe |
| Disk capacity | Approximately 1 TB |
| C: total space | 952.78 GB |
| C: free space | 807.84 GB |
| Architecture | AMD64 |

**Commands used:**

| Fact | PowerShell command |
|---|---|
| CPU model and cores | `Get-CimInstance Win32_Processor` |
| Memory information | `Get-CimInstance Win32_PhysicalMemory` |
| Disk model and type | `Get-PhysicalDisk` |
| Free disk space | `Get-Volume C` |
| Architecture | `$env:PROCESSOR_ARCHITECTURE` |

### 2. Linux — Ubuntu Server

Ubuntu was running inside Oracle VirtualBox as a virtual machine.

| Fact | Result |
|---|---|
| CPU model | AMD Ryzen 5 4600H with Radeon Graphics |
| Virtual CPUs | 2 |
| CPU threads | 2 |
| Total RAM | 3.3 GiB |
| Used RAM | 405 MiB |
| Available RAM | 2.9 GiB |
| Swap | 2.0 GiB |
| Disk model | VBOX HARDDISK |
| Disk interface | SATA |
| Virtual disk size | 25 GB |
| Root partition used | 5.2 GB |
| Root partition free | 19 GB |
| Architecture | x86_64 |
| Virtualization | Oracle VirtualBox |

**Commands used:**

| Fact | Linux command |
|---|---|
| CPU model and cores | `lscpu` |
| Memory information | `free -h` |
| Memory modules | `sudo dmidecode -t memory` |
| Disk model and type | `lsblk -d -o NAME,MODEL,ROTA,TRAN,SIZE` |
| Free disk space | `df -h /` |
| Architecture | `uname -m` |
| Virtualization type | `systemd-detect-virt` |

### 3. macOS

macOS was not available during this laboratory, so no macOS commands or results were collected.

### 4. Operating System Comparison

| Fact | Windows | Linux | macOS |
|---|---|---|---|
| CPU model | `Win32_Processor` | `lscpu` | Not tested |
| Cores / threads | `Win32_Processor` | `lscpu` | Not tested |
| Total memory | `Win32_PhysicalMemory` | `free -h` | Not tested |
| Memory modules and speed | `Win32_PhysicalMemory` | `dmidecode -t memory` | Not tested |
| Disk model and type | `Get-PhysicalDisk` | `lsblk` | Not tested |
| Free space | `Get-Volume C` | `df -h /` | Not tested |
| Architecture | `$env:PROCESSOR_ARCHITECTURE` | `uname -m` | Not tested |

### 5. Comparison and Observations

Windows and Linux use different commands to display hardware information. Windows uses PowerShell commands such as `Get-CimInstance` and `Get-PhysicalDisk`, while Linux uses commands such as `lscpu`, `free -h` and `lsblk`.

Windows detected the physical AMD Ryzen 9 9955HX processor with 16 cores and 32 logical processors, as well as 32 GB of DDR5 RAM. Ubuntu, running inside a virtual machine, detected only 2 virtual CPUs and approximately 3.3 GiB of RAM.

The disk information was also different. Windows displayed a Samsung NVMe SSD with approximately 1 TB capacity, while Ubuntu displayed a virtual disk called VBOX HARDDISK with 25 GB capacity.

This demonstrates that a virtual machine does not directly see all physical hardware. The hypervisor provides virtual CPU, memory and storage resources to the guest operating system.

---

## What Did Not Work the First Time

The `sudo dmidecode -t memory` command did not display information about the physical memory modules. It only showed that SMBIOS 2.5 was present.

This happened because Ubuntu was running inside a virtual machine and did not receive complete physical memory information from the host system.

The `systemd-detect-virt` command returned `oracle`, confirming that the operating system was running inside Oracle VirtualBox.

---

## Evidence

The following files contain the command outputs:

- `evidence/windows-specs.txt` — Windows PowerShell hardware information.
- `evidence/linux-specs.txt` — Ubuntu hardware information.
- `evidence/photos/` — Product photographs of the ten hardware components.

