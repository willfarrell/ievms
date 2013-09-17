This project is a spin off of [xdissent/ievms](https://github.com/xdissent/ievms). This project installs vms for VMWare Fusion instead of VirtualBox.

Overview
========

Microsoft provides virtual machine disk images to facilitate website testing 
in multiple versions of IE, regardless of the host operating system. 
~~Unfortunately, setting these virtual machines up without Microsoft's VirtualPC
can be extremely difficult. The ievms scripts aim to facilitate that process using
VirtualBox on Linux or OS X.~~ With a single command, you can have IE6, IE7, IE8,
IE9, IE10 and IE11 running in separate virtual machines. 

**NOTE:** As of Feb. 1st, 2013, the [MS images](http://www.modern.ie/virtualization-tools)
are fully compatible with VMWare Fusion, thanks to the [modern.IE](http://modern.IE)
project.


Quickstart
==========

Just paste this into a terminal: `curl -s https://raw.github.com/willfarrell/ievms/master/ievms.sh | bash`


Requirements
============

* VMWare Fusion (http://www.vmware.com/products/fusion/)
* Curl (Ubuntu: `sudo apt-get install curl`)
* Linux Only: unar (Ubuntu: `sudo apt-get install unar`)
* Patience


Disk requirements
-----------------

A full ievms install will require approximately 48G:

    Servo:.ievms xdissent$ du -ch *
     11G    IE10 - Win7-disk1.vmdk
     22M    IE10-Windows6.1-x86-en-us.exe
     11G    IE11 - Win7-disk1.vmdk
     28M    IE11-Windows6.1-x86-en-us.exe
    1.5G    IE6 - WinXP-disk1.vmdk
    724M    IE6 - WinXP.ova
    717M    IE6_WinXP.zip
    1.6G    IE7 - WinXP-disk1.vmdk
     15M    IE7-WindowsXP-x86-enu.exe
    1.6G    IE8 - WinXP-disk1.vmdk
     16M    IE8-WindowsXP-x86-ENU.exe
     11G    IE9 - Win7-disk1.vmdk
    4.7G    IE9 - Win7.ova
    4.7G    IE9_Win7.zip
    3.4M    ievms-control-0.1.0.iso
    4.6M    lsar
    4.5M    unar
    4.1M    unar1.5.zip
     48G    total
   
You may remove all files except `*.vmdk` after installation and they will be
re-downloaded if ievms is run again in the future:

    $ find ~/.ievms -type f ! -name "*.vmdk" -exec rm {} \;

If all installation related files are removed, around 37G is required:

    Servo:.ievms xdissent$ du -ch *
     11G    IE10 - Win7-disk1.vmdk
     11G    IE11 - Win7-disk1.vmdk
    1.5G    IE6 - WinXP-disk1.vmdk
    1.6G    IE7 - WinXP-disk1.vmdk
    1.6G    IE8 - WinXP-disk1.vmdk
     11G    IE9 - Win7-disk1.vmdk
     37G    total


Bandwidth requirements
----------------------

A full installation will download roughly 7.5G of data.

**NOTE:** Reusing the XP VM for IE7 and IE8 (the default) saves an incredible
amount of space and bandwidth. If it is disabled (`REUSE_XP=no`) the disk space
required climbs to 74G (39G if cleaned post-install) and around 17G will be 
downloaded. Reusing the Win7 VM on the other hand (also the default), saves
tons of bandwidth but pretty much breaks even on disk space. Disable it with 
`REUSE_WIN7=no`.


Installation
============

1. Install VirtualBox (make sure command line utilities are selected and installed).

2. Download and unpack ievms:

   * Install IE versions 6, 7, 8, 9, 10 and 11.

        curl -s https://raw.github.com/willfarrell/ievms/master/ievms.sh | bash

   * Install specific IE versions (IE7 and IE9 only for example):

        curl -s https://raw.github.com/willfarrell/ievms/master/ievms.sh | env IEVMS_VERSIONS="7 9" bash

3. Launch VMWare Fusion.

4. Choose ievms image from VMWare Fusion.

The OVA images are massive and can take hours or tens of minutes to 
download, depending on the speed of your internet connection. You might want
to start the install and then go catch a movie, or maybe dinner, or both. 


Recovering from a failed installation
-------------------------------------

Each version is installed into `~/.ievms/` (or `INSTALL_PATH`). If the installation fails
for any reason (corrupted download, for instance), delete the appropriate ZIP/ova file
and rerun the install.

If nothing else, you can delete `~/.ievms` (or `INSTALL_PATH`) and rerun the install.


Specifying the install path
---------------------------

To specify where the VMs are installed, use the `INSTALL_PATH` variable:

    curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | env INSTALL_PATH="/Path/to/.ievms" bash


Passing additional options to curl
----------------------------------

The `curl` command is passed any options present in the `CURL_OPTS` 
environment variable. For example, you can set a download speed limit:

    curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | env CURL_OPTS="--limit-rate 50k" bash


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

~~If one of the comically large files fails to download, the `curl` 
command used will automatically attempt to resume where it left off.~~
Unfortunately, the modern.IE download servers do not support resume.


Acknowledgements
================

* [modern.IE](http://modern.ie) - Provider of IE VM images.
* [xdissent/ievms](https://github.com/xdissent/ievms) - This is a spin off of xdissent/ievms. This project installs vms for VMWare Fusion instead of VirtualBox.

License
=======

None. (To quote Morrissey, "take it, it's yours")