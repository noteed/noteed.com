---
title: Mini
date: 2020-07-02
---


# Backstory

In June 2020, I'v decided to build a workstation. Except for a NUC, I think I
only had laptops since about the year 2002. My first idea was to build a small
machine: probably a Ryzen 3900x using an ITX motherboard, that could fit in a
[NZXT H1 case](https://www.nzxt.com/product-overview/h1). (There is this
[Asrock X570-based
motherboard](https://www.asrockrack.com/general/productdetail.asp?Model=X570D4I-2T#Specifications),
supporting 128GB of memory.)

Then I read a bit more about some AMD CPUs (Ryzen, Threadripper, and EPYC) and
I became interested, for fun, in the idea of a "real" CPU and a "real"
motherboard: with a BMC supporting IPMI, and the possibility to create a dual
socket system.

And I went overboard: a Supermicro, dual socket motherboard, with 16 memory
slots.  As it uses an E-ATX form factor, I had to choose a bigger case. The
result is a little monster, dubbed "Mini".


# Components

- 1x Thermaltake A700 case
- 1x SuperMicro H11DSi-NT motherboard
- 2x EPYC 7282 CPUs -- total: 32 cores
- 16x 16GB memory sticks -- total: 256GB

This is nifty: you can create about 30 VMs, each receiving 1 core and 8GB, and
keep 2 cores and 16GB for the host (or 60 VMs, each receiving 1 hardware thread
and 4GB).

https://www.supermicro.com/en/products/motherboard/H11DSi-NT

On Max ICT, the RAM is listead as:

```
SuperMicro 16gb ddr4-2666 2rx8 ecc rdimm
Max nr: 8966753 | EAN: | Fabrikant: SuperMicro | Type: MEM-DR416L-CL03-ER26
€84,03 EXCL BTW
```

The description is: "Micron 16gb ddr4-2666 2rx8 ecc rdimm
mem-dr416l-cl03-er26".

I think [`Max nr:
8966753`](https://maxict.nl/supermicro-16gb-ddr4-2666-2rx8-ecc-rdimm-p8966753.html)
is their internal identification number.

The motherboard is listed as:

https://maxict.nl/supermicro-h11dsi-nt-verlengd-atx-server-werkstationmoederbord-p8261934.html

```
SuperMicro H11DSi-NT Extended ATX Server / Workstation Motherboard
Max no: 8261934 | EAN: 672042286126 | Manufacturer: SuperMicro | Type: MBD-H11DSi-NT-O
€538,75 EXCL BTW
```

Supermicro uses `-O` for the retailer version, that comes with a proper
packaging.  This is in contrast with `-B` which is the bulk packaging.

Naming convention: https://www.supermicro.com/products/Product_Naming_Convention/Naming_MBD_amd.cfm

`H11` means 1st generation AMD EPYC, but the main page says revision 2 supports
the second generation (i.e. 7002 series). I tried to contact Max ICT before
purchase to make sure I would get a revision 2 but they never answered.

`D` means Dual CPU.

`S` means the socket type is SP3, suitable for EPYC CPUs. (Threadripper is TR4,
regular Ryzen is AM4).

`i` means SATA only, but:

`NT` means NVMe support and 10GBase-T networking.

The manual is MNL-2027.pdf.


The CPU is listead as:

https://maxict.nl/amd-epyc-7282-processor-28-ghz-box-64-mb-l3-p12675552.html

```
AMD EPYC 7282 processor 2,8 GHz Box 64 MB L3
Max nr: 12675552 | EAN: 730143310161 | Fabrikant: AMD | Type: 100-100000078WOF
€661,00 EXCL BTW
```




# Stupid stuff I've done

I tried to see if there was Supermicro logo without CPU and RAM, but nope. I
think I read once that the BIOS actually uses the host CPU.

I didn't slide the CPU enough before I lowered it. I feared I broke the fragile
underneath.

I didn't put a heatsink on the CPU. I saw the Supermicro logo, tried to go into
the BIOS, but the CPU actually overheated, provoking a beep and a red light.

I thought I could connect to the IPMI like in this post:
https://datto.engineering/post/taking-apart-ipmi but I didn't found URT pins.

The keyboard is not always recognized in the USB port. I can remove it and put
it back and it works (but I have to act quickly during the boot prompt of the
NixOS iso).

When I plugged the keyboard in onther USB slot (one not touching the dedicated
ethernet), it seemed to always work.

I added one CPU in the CPU1 socket, and one stick of RAM, in the DIMMA1 slot.

There is a message on the mb saying ALWAYS POPULATE DIMMx1 FIRST...

I added one CPU in the CPU1 socket, and one stick of RAM, in the P1-DIMMA1 slot.

There is a message on the mb saying ALWAYS POPULATE DIMMx1 FIRST...

I booted on a USB stick with NixOS, ran memtest86... and it was all red, with PASS 0%...

I booted NixOS in copytoram mode, and it was ok.

I added another stick of RAM in P2-DIMMA1, but it was not recognized when I did free -h.

I added the second CPU, and RAM was visible with free -h.

I added more RAM. At some point the kernel was no longer starting with "Booting
the kernel" message and stuck.

I removed some sticks that started again, trying almost at each newly added stick.

I've made a mistake: A bought a 970 EVO Plus. This is a PCIe x... but the M.2
connection on the h11dsi is only ... (although other connectors are ...).

To provide Mini with some networking, I used my old WiFi extender, which has an
ethernet port.

When an ethernet wire is connect to LAN1, I saw when turning on the motherboard:
"BMC IP 192.168.1.7" (which was probably given by DHCP ny the extender).

Or similar after configuring a static IP within the BIOS to the dedicated
interface.

And within the NixOS installer, `ip a s` shows that eno1 received got 192.168.1.8.

Connecting to 192.168.1.7 with a browser is a HTTPS connection with an
untrusted certificate with a common name "IPMI" and organization "Super Micro
Computer".

A login/password form is display. The login is ADMIN in uppercase, the password
is on a label near FANA (BMC: xxx, PWD: xxx).

Logo: "System normal", System critical" when LED2 is red
Logo: Feature Support: Redfish

This displays:

```
Firmware Revision: 01.52.00      IP Address: 192.168.001.007
Firmware Build Time: 11/18/2019  BMC MAC Address: xx:xx:xx:xx:xx:xx
BIOS Version: 2.1                System LAN1 MAC Address: xx:xx:xx:xx:xx:xx
BIOS Build Time: 02/21/2020      System LAN2 MAC Address: ac:1f:6b:e5:0d:f9
Redfish Version: 1.0.1
CPLD Version: 04.00.14
```

And below, a button to turn on and off the computer. What a weird feeling to
use a bare metal computer like a VM !
Power On, Power Down, Reset

In the configuration menu, it is possible to upload a new cert and key.


Fan to Optimal speed or Normal speed are slow then triggered when LED2 goes red.
On Full, they run as when the LED2 is red.

Conf/Syslog shows a message about a reauired license.

iKVM/HTML5 shows the same thing as Remote Console Preview on the main page.

Virtual media:

> Use these pages to upload and share images to the BMC. The image will be emulated to the host as a USB device.
>     Floppy Disk: Upload a binary image with a maximum size of 1.44MB. This image will be emulated to the host as a USB device.
>     CD-ROM Image: Share a CD-ROM image over a Windows share with a maximum size of 4.7GB. This image will be emulated to the host as a USB device.

The Windows share uses: Share Host, Path To Image, optional User, optional Password.

The Help menu activates a small description on each page.


Keyboard pluged out/in: could type once enter (I think) then: usbhid 1-2:1.1:
can't add hid device: -110 appeared.

IMPI SOL:

```
$ ipmitool -H 192.168.1.7 -U ADMIN -P "$(cat ipmi-password.txt)" sol activate -I lanplus
```

It seems if I want to see BIOS messages, I should activate Enable Console
Redirection for COM2/SOL (in the BIOS).

```
$ ipmitool -H 192.168.1.7 -U ADMIN -P "$(cat ipmi-password.txt)" -I lanplus power status
Chassis Power is off
```

This will affect the next boot, this is useful to not have to hit DEL or CTRL-S:

```
$ ipmitool -H 192.168.1.7 -U ADMIN -P "$(cat ipmi-password.txt)" -I lanplus chassis bootdev bios
Set Boot Device to bios
```

There is also a SSH server:

```
$ ssh ADMIN@192.168.100.3
```

For ipmiconsole: `$ nix-shell -p ipmitool freeipmi`:

```
$ ipmiconsole -h 192.168.100.3 -u ADMIN -p "$(cat ipmi-password.txt)"
[SOL established]
```

Quit with the escape sequence `&.`.

I was not able to enable COM1 redirection, disable SOL redirection, and make by
ttyUSB0 cable work.

When I add SOL redirection, ipmiconsole worked, including the NixOS boot and
login prompt ( I added console=tty1 and console=ttyS1,115200 after hitting tab
during the grub menu). But I didn't see the menu with ipmiconsole...

## NixOS

I've downloaded nixos-minimal-20.03.2651.0a40a3999eb-x86_64-linux.iso

I've used it to boot on a USB key.

Using memtest86 on a single RAM installed produced 'PASS: 0%'...



On netboot.xyz, on boot method, they should add Floppy disk (which can be downloaded)

I've renamed it to .img.
usb to ima.
iso to ima.

But nothing shows up after "upload".

dsk to ima seems ok (after truncate ?), then sdb message appears on screen (i've made a picture)
And indeed, lsblk shows a sdb 1.4M disk, then:

```
$ ipmitool -H 192.168.1.10 -U ADMIN -P "$(cat ipmi-password.txt)" -I lanplus chassis bootdev floppy
Set Boot Device to floppy
$ ipmitool -H 192.168.1.10 -U ADMIN -P "$(cat ipmi-password.txt)" -I lanplus chassis power cycle
Chassis Power Control: Cycle
```

Mmm maybe this din't work because I still had my NixOS USB key plugged in.

I should use ZFS.

I'd like to run NixOS in memory, with only /nix/store present on the hard
drive, acting as a binary cache.

So I'm wondering how I should do that:

- I think NixOS installer assumes the disk to be formatted before hand.
- Then I guess stage-1 looks for specific partitions.
- But the installer itself runs from RAM, so maybe a custom version of that
  would be ok.

- I could upload a netboot.xyz custom floppy, which then iPXE boot a NixOS
  image stored on the internet.
- I could use pixiecore for a PXE boot.
- I think the Supermicro motherboard supports HTTP boot. I should see it works,
  and what I can do with it.
