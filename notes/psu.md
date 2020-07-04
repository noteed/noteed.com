---
title: PSU
---

> A power supply unit (or PSU) converts mains AC to low-voltage regulated DC
> power for the internal components of a computer.

See [Wikipedia].

[Wikipedia]: https://en.wikipedia.org/wiki/Power_supply_unit_(computer)


## On

Turning on a power supply is done by a signal from the motherboard through its
power plug. Indeed, testing a PSU when it is not connected to anything can be
done by shorting two appropriate pins. In the packaging of my Seasonic Focus
PX-850, there is a "power supply tester" that can be fitted to the 24-pin
motherboard connector, shorting the two appropriate pins.

(I bought the above Seasonic PSU in june 2020 to build a [little workstation].)


## Rails

It seems a rail is a one or more groups of cables (and thus connectors) that
share the same circuitry and current sensor. Multiple rails can be present in a
PSU to split the available load (sometimes called power distribution), so that
a single rail failure offers a limited risk.

Conversely, a PSU with a single rail is simpler to use as there is no need to
balance the load.

(My Seasonic has a single +12V rail, delivering 70A (i.e.  840W), in addition
of other minor rails).


## +5VSB

I was wondering how a BMC could be running on a motherboard when the PSU was
switched off. The ATX specification includes a +5V standby voltage, present as
the pin 9 (purple) of the 24-pin motherboard connector.

[little workstation]: mini.md
