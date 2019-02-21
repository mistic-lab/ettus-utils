# ettus-utils
Utilities and notes for working with Ettus Instruments

# Installing Utilities

To install these scripts, simply clone this repo and from within the folder run

`./scripts.sh install`

This will link the various utility scripts into `~/bin` and hopefully to your path. It will also create a `config.sh` which can be modified for your environment, it is gitignored and isn't committed to the repo.

Once installed, you should be able to use the scripts like:

| Utility | Description |
|`EThreeTen`| Utilities for working with the E310 (will show list of commands if left empty)|


## Getting USRP's Setup

- change nic to manual ip address of `192.168.10.1`
- run `uhd_find_devices` to make sure the USRP is available
- run `uhd_usrp_probe`
- Update the firmware via:

```sh
 "/usr/lib/uhd/utils/uhd_images_downloader.py"
 "/usr/bin/uhd_image_loader" \
    --args="type=usrp2,addr=192.168.10.2"
```

> You must unplug the USRP before the firmware will take effect


### Changing IP Address

- Get serial number from `uhd_find_devices`

```sh
/usr/lib/uhd/utils$ ./usrp_burn_mb_eeprom --args="serial=E0R13WCUP" --values="ip-addr=192.168.10.3"
```

## E310

[E310 Docs](https://kb.ettus.com/E310/E312_Getting_Started_Guides)

> Make sure your Linux kernel and software are updating.  I ran into a problem with the usb device not being mounted until I updated the system software.

> NOTE: The following docs are just here for information, but all has been codified in the `EThreeTen` utility in this directory

#### Mounting Host directory into E310
- Log into E310:
  `user@host$ ssh root@192.168.10.4`
- Mount host directory
  `root@ettus-e3xx-sg1:~# sshfs user@host:/home/user/Documents ./mounted_dir/`

#### Starting Gnu radio over ssh with x forwarding

from host machine log into e310 with ssh (with x forwarding):
`cjam@mistic-spruce$ ssh -X root@192.168.10.4`

then start gnu radio companion:
`root@ettus-e3xx-sg1:~# gnuradio-companion`

