This project is a spin off of [xdissent/ievms](https://github.com/xdissent/ievms). This project installs vms for VMWare Fusion instead of VirtualBox.

Overview
========

Microsoft provides virtual machine disk images to facilitate website testing 
in multiple versions of IE, regardless of the host operating system. With a single command, you can have IE6, IE7, IE8, IE9, IE10 and IE11 running in separate virtual machines. 

**NOTE:** As of Feb. 1st, 2013, the [MS images](http://www.modern.ie/virtualization-tools)
are fully compatible with VMWare Fusion, thanks to the [modern.IE](http://modern.IE)
project.


Quickstart
==========

Just paste this into a terminal: `curl -s https://raw.githubusercontent.com/willfarrell/ievms/master/ievms.sh | bash`


Requirements
============

* VMWare Fusion (http://www.vmware.com/products/fusion/)
* Curl (Ubuntu: `sudo apt-get install curl`)
* Patience


Disk requirements
-----------------

A full ievms install will require approximately 83G:

```bash
$ du -chd 0 *
977M	IE10.Win7.For.MacVMware.part01.sfx
977M	IE10.Win7.For.MacVMware.part02.rar
977M	IE10.Win7.For.MacVMware.part03.rar
274M	IE10.Win7.For.MacVMware.part04.rar
9.1G	IE10.Win7.For.MacVMware.vmwarevm
977M	IE10.Win8.For.MacVMware.part1.sfx
977M	IE10.Win8.For.MacVMware.part2.rar
457M	IE10.Win8.For.MacVMware.part3.rar
7.3G	IE10.Win8.For.MacVMware.vmwarevm
977M	IE11.Win7.For.MacVMware.part01.sfx
977M	IE11.Win7.For.MacVMware.part02.rar
977M	IE11.Win7.For.MacVMware.part03.rar
301M	IE11.Win7.For.MacVMware.part04.rar
9.2G	IE11.Win7.For.MacVMware.vmwarevm
977M	IE11.Win8.1Preview.For.MacVMware.part1.sfx
977M	IE11.Win8.1Preview.For.MacVMware.part2.rar
259M	IE11.Win8.1Preview.For.MacVMware.part3.rar
5.5G	IE11.Win8.1Preview.For.MacVMware.vmwarevm
699M	IE6.XP.For.MacVMware.sfx
1.6G	IE6.XP.For.MacVMware.vmwarevm
977M	IE7.Vista.For.MacVMware.part01.sfx
977M	IE7.Vista.For.MacVMware.part02.rar
977M	IE7.Vista.For.MacVMware.part03.rar
217M	IE7.Vista.For.MacVMware.part04.rar
 11G	IE7.Vista.For.MacVMware.vmwarevm
977M	IE8.Win7.For.MacVMware.part01.sfx
977M	IE8.Win7.For.MacVMware.part02.rar
790M	IE8.Win7.For.MacVMware.part03.rar
8.4G	IE8.Win7.For.MacVMware.vmwarevm
864M	IE8.XP.For.MacVMware.sfx
1.9G	IE8.XP.For.MacVMware.vmwarevm
977M	IE9.Win7.For.MacVMware.part01.sfx
977M	IE9.Win7.For.MacVMware.part02.rar
868M	IE9.Win7.For.MacVMware.part03.rar
8.7G	IE9.Win7.For.MacVMware.vmwarevm
 83G	total
```

You may remove all files except `*.vmwarevm` after installation and they will be
re-downloaded if ievms is run again in the future.

If all installation related files are removed, around 62G is required:

```bash
$ du -chd 0 *
9.1G	IE10.Win7.For.MacVMware.vmwarevm
7.3G	IE10.Win8.For.MacVMware.vmwarevm
9.2G	IE11.Win7.For.MacVMware.vmwarevm
5.5G	IE11.Win8.1Preview.For.MacVMware.vmwarevm
1.6G	IE6.XP.For.MacVMware.vmwarevm
 11G	IE7.Vista.For.MacVMware.vmwarevm
8.4G	IE8.Win7.For.MacVMware.vmwarevm
1.9G	IE8.XP.For.MacVMware.vmwarevm
8.7G	IE9.Win7.For.MacVMware.vmwarevm
 62G	total
```


Bandwidth requirements
----------------------

A full installation will download roughly 21G of data.


Installation
============

1. Install VMWare Fusion (make sure command line utilities are selected and installed).

2. Download and unpack ievms:

   * Install IE versions 6, 7, 8, 9, 10 and 11.

        curl -s https://raw.githubusercontent.com/willfarrell/ievms/master/ievms.sh | bash

   * Install specific IE versions (IE7 and IE9 only for example):

        curl -s https://raw.githubusercontent.com/willfarrell/ievms/master/ievms.sh | env IEVMS_VERSIONS="7 9" bash

3. Launch VMWare Fusion.

4. Choose ievms image from VMWare Fusion.

The vmwarevm images are massive and can take hours or tens of minutes to 
download, depending on the speed of your internet connection. You might want
to start the install and then go catch a power nap, or start a new project, or both. 


Recovering from a failed installation
-------------------------------------

Each version is installed into `~/Virtual Machines/`. If the installation fails for any reason (corrupted download, for instance), just rerun the script. 

If nothing else, you can delete `~/Virtual Machines` and rerun the install.


Passing additional options to curl
----------------------------------

The `curl` command is passed any options present in the `CURL_OPTS` 
environment variable. For example, you can set a download speed limit:

    curl -s https://raw.githubusercontent.com/willfarrell/ievms/master/ievms.sh | env CURL_OPTS="--limit-rate 50k" bash


Features
========


Clean Snapshot
--------------

A snapshot is automatically taken upon install, allowing rollback to the
pristine virtual environment configuration. Anything can go wrong in 
Windows and rather than having to worry about maintaining a stable VM,
you can simply revert to the `clean` snapshot to reset your VM to the
initial state.


Guest Control
-------------

VirtualBox guest additions are installed after each virtual machine is created
(and before the clean snapshot) and the appropriate steps are taken to enable
guest control from the host machine.


Resuming Downloads
------------------

Unfortunately, the modern.IE download servers do not support resume. The script will only redownload any files that do not match their md5 hash.


Acknowledgements
================

* [modern.IE](http://modern.ie) - Provider of IE VM images.
* [xdissent/ievms](https://github.com/xdissent/ievms) - This is a spin off of xdissent/ievms. This project installs vms for VMWare Fusion instead of VirtualBox.

License
=======

None. (To quote Morrissey, "take it, it's yours")
