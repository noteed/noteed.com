---
title: Mini
date: 2020-07-02
---

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

And I went overboard: a Supermicro, dual socket motherboard, with 16 PCI-E
slots. As it uses a E-ATX form factor, I had to choose a bigger case. The
result is a little monster, dubbed "Mini".


# Components

- 1x Thermaltake A700 case
- 2x EPYC 7282 CPUs -- total: 32 cores
- 16x 16GB memory sticks -- total: 256GB

This is nifty: you can create about 30 VMs, each receiving 1 core and 8GB, and
keep 2 cores and 16GB for the host (or 60 VMs, each receiving 1 hardware thread
and 4GB).
