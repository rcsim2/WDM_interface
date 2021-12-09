# WDM_interface

Transmitter interface and WDM parallel port driver

![Interface.doc](https://blacksphere2.github.io/screenshots/ss99.jpg)

* Txintpar is based on Walter Oney's ConvertWDM sample
* Txintpar2 is based on the NT DDK's PARSIMP sample
* Txintpar3 is based on the Win2000 DDK's PARCLASS sample (a bus driver)

Txintpar2 finally lead to a working parallel port driver for our interface.

There does seem to be a way to dynamically load a WDM driver, but only when it is a KMD-style driver (no AddDevice() and no PnP). You must use the Service Control Manager functions. It is described here: http://www.codeproject.com/system/driverdev.asp
