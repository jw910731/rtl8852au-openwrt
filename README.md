# kmod-rtl8852au for OpenWRT 23.05.5
This repository is inteded to place under `<openwrt source root>/package/kernel` to make OpenWRT support rtl8852au usb wifi NIC.
To be honest, I finally gived up fixing the driver and give back the hardware to the mart. Don't expect this to work properly, you might need do more fixes to make it work.

# Current status
Whole project is based on [lwfinger/rtl8852au](https://github.com/lwfinger/rtl8852au) project.

Since I was going to use this to build a WiFi relay, STA-AP mode is enabled in the driver.
Cause OpenWRT do not use in-kernel wireless driver, some patches are made to adapt backport(mac80211).
Makefile are patched to debug mode, though it didn't seems to be working. :(

There's still some unknown bug to cause userspace communicating through netlink causes the call to freeze and the process is then change into uninterruptable mode(status D).
Causing `ip addr` or other network related control command to freeze.

# Notice
The original driver maintainer @lwfinger had passed away. RIP. [Data Source](https://www.phoronix.com/news/Larry-Finger-Linux-Wireless)
I will not put any effort to improve this project, since the hardware have gived back to the mart.
So this repository is abandoned and DO NOT ACCEPT ANY PRs or ISSUEs.
