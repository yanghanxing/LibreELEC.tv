# RK3328 bootloader blobs

Copied from https://github.com/rockchip-linux/rkbin or extracted from firmware images

## Tools used

- afptool and rkImageMaker to unpack firmware
- rk-splitboot from https://github.com/apxii/rkboottools to extract ddr and miniloader blob

## Unpack firmware

```
> mkdir out
> rkImageMaker -unpack rk3328_loader_ddr3_2GB_786MHz_v1.04.239.img out

Unpacking image, please wait...
Exporting boot.bin
Exporting firmware.img
Unpacking image success.

> afptool -unpack out\firmware.img out

Check file... OK
------- UNPACK ------
package-file    0x00000800      0x00000230
MiniLoaderAll.bin       0x00001000      0x0002314E
parameter.txt   0x00024800      0x0000031D
trust.img       0x00025000      0x00400000
uboot.img       0x00425000      0x00400000
misc.img        0x00825000      0x0000C000
resource.img    0x00831000      0x00606A00
kernel.img      0x00E38000      0x00E4D834
boot.img        0x01C86000      0x00187FE8
recovery.img    0x01E0E000      0x01450000
system.img      0x0325E000      0x60000000
Unpack firmware OK!
------ OK ------
```

## Extract ddr and miniloader blob

```
> ./rk-splitboot boot.bin
> mv FlashData rk322xh_ddr3_2GB_786MHz_v1.04.bin
> mv FlashBoot rk322xh_miniloader_v2.39.bin
```

NOTE: Trailing zero padding can be truncated
