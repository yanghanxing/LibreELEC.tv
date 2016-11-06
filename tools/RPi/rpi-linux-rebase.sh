#!/bin/bash

################################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

# Setup:
# git clone -b rpi-4.4.y --depth=1000 --single-branch git://github.com/raspberrypi/linux.git raspberrypi-linux
# git remote add -t linux-4.4.y linux-stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
# git config --local core.abbrev 12
# Update:
# git fetch --all --depth=1000
# git reset --hard origin/rpi-4.4.y
# GIT_SEQUENCE_EDITOR=../rpi-linux-rebase.sh git rebase -i linux-stable/linux-4.4.y
# git format-patch --no-renames --no-signature --stdout linux-stable/linux-4.4.y > ../linux-01-RPi_support.patch

TODO=$1

# Drop commits already in linux-stable/linux-4.4.y
DROP_COMMITS="2939a6e5ab60 ce5ef4bf664f ed1a385b985c 88a0271b4e30 3c597eb81bd7 a0ef44a0092b cb70112d9894 7a48422e97d0 70e5f53f8281 6b155414a3e7 5bfaacbc16aa 893ea2be0b06 331810b0d156 56c4087483df e36038d232b7 d5d029a837a8 9a64d336205e 240a35df930c 744368510c23 ff4f4c885c5e 3cffc43fc8fe a76a6d1c55da 2318da4b1891 0e446d5409b9 3e1965497ca0 01011ae56267 487b2617f8d8 e605a714ecf2 42e0e0844230 eba4b9910786 a4500c40fe79 e480ee049e07 c048ff699606 65d5189e3a9a 45baf3bd70ec 1c7884616ba6 b4205141fbc6 f0e6790de71b b6ad5bcaa8f9 fc90e371bf9b 4cc29f9f3234 c4ee8c37304a cc77c994097e b87299949043 33b400e87c25 1ab82a918e02 880b924004ba c2480234d69a 8506eff19c8f 0ce2e81304de 8b26506d0e09 13c617a5d486 a84c5d56dd85 a5bf6aa2cb6b 9b1cf98c6c59 aa221f8b09c9 560924ecd38c 2149b72dfdb5 4ba01777f6b7 7bda4c3acc39 d4f632093309 c1039ae939c9 02ade29f2c6a 3da467be4524 a1a2862bf47c 3632b72cf15a 118da7be2845 e32c4a3313d3 abed33bcb6b0 fc0b0fd7e6fd 6906fd7dbee4 819af8b10605 4dea37ea0297 f4200c510ed3 cb224ebad413 34f4b416d5de 1724a5013ada 6b8710c8a9a6 619c8a8ea495 e8c128d25979 ecf33b69a23a 0761d207bcff efe96ad3f691 dfbe9c156daa 8540f2ffc304 e36deb48f10e f10fd3835a6b 6c2c29eec900 9bcbceee0e7c 219096b7d5ca b13b748fef4e e408431c10d0 e9e4d19ce6f9 ad4c6d3cdece f3e7e7b5910a d72bf6dff9e8 3ecf09f3b46c c3b11993eb19 9d27e46e191c 19e81dee805d d7496885b2a4 d4ff583f4263 2d96c3a8cb35 13f5100fb2a9 bfed657e8f8e 566b8c0ea4a0 013c13500927 1e0a388b3571 18ec31863b25 91147893ab40 7334f6bc41ab b79f5eb98b11 9defb3485622 a065c1ff10ae 7662dc11ecae 2960002f7f24 67a9cbdbc7b7 05713dba9fbe 8b860ab60bdd fe0a729efa9d 9a7414002811 ec27487bb5f1 5fb5a6790b51 8a7deaee6171 77ed0efcf8b3 d1c98ddfb441 87a18d21eb9e 36c88cccc704 b18e9ea17990 41c55d2b8782 2e8c58e25a69 76af090447c9 2c13f5c9ef77 5957239a1774 ba30e745b41e 7d010dde80a9 05505d7a3ede 7f25bc5dc6b2 b885874dde14 b543d6bf5b53 e4e819493982 e065b6171fdf bc968de5e7fc 8f258e0e9ad3 70574f9dbe40 b46ad697ab3e b5d5ea5a2809 749fa922f961 6f0ad9d3b8c8 63ca2e80465f 926906b42549 3b14eedd4a00 dbe0c1539c36 657ee9758a8c 049ad1e7b3ea b6a0b003c4b8 ba264c7e2235 3e2f3f1d79e4 38753f6df1f5 d06cf99e37b9 a16c2b2d4d22 59e6aee8b31d 0451a851f40a 08cd193eeb5f b544858cd554 388e14534152 935203b9a600 80a076f965dc 1627db4ac7e8 8766c6859fff f6be7da237d3 fa857f795d33 13632b8765d7 a7913eb184f4 1644e94028fb 49e7a742d09c bcf28d16e852 7f712948bcc3 d596bf4e4381 8b6e8251a1e1 169ea0433387 a4ef72af58c9 e0db2f2ab776 bdbab78e4e5b 3e31b24cb106 423fc0d47012 35946d2e5920 036c0860e490 2fdbe5f061d4 915555202741 9c620bf09b33 66665d255d13 de0c408e88d4 f9912037a997 2cf179f2d132 29c585bfde35 21c49e313654 292f995562cf 02b00866866a d03df7fcb1ff 6d57eb06f7ad 2e4bdd72199f 9ba63cebede9 77841a16932b 53acc9dd068a 37e68a2ab7ce 75d2d989e586 e3767d74c74f 0605b4b8d4ce 4ddebb82c0d9 5223d724760e b6eb7d602e29 fdefe09768bf eabf1620c0b9 103883faf1c7 b403aa8a4015 5dccaecd48ed 97a3108fa7b2 a0293f146ab3 763e8ce56a74 d9955283043d 7e4a2e55a8ae 49d6d9d961ff 42441572b80a 6ebfb0ec6ffb 4852bc0a9b88 88fa6c6e9607 051d07d60645 9612277f0de2 1b1d1a441ce6 1b59b3a72096 7ded4aebee6f b76b2b9c0292 4fbed9bed36c 8a76f9e2e5a5 753c563c944a a954b12154ab e381800c4cff d4c8d7d6f08b 6f876eefbcf4 0d1281dd51d0 b90938a3b0ed d7007b12eedd 5013cec43e9f bebc82ddbae0 71bc02bd2638 094bcab10561 45a96e4e4524 f584ad9eccc7 6deae1015688 9d50f4a10106 5d5ca6f7b5e3 a053b72baf65 28942927073f f85b3b1c79c1 202f4e45396b 29ed213b7c5b 9aaa9ad0064b 61d09701d9e2 9540eb2fab0f f80b24fd3438 20582e21edd8 f09bb37b7c1b 58c943085e75 82ff62792fdb 2b4437a91134 0523e68f8a99 5f373f02dd8a 3b0c39d4713d 4f5a5b1f5b30 373480152b63 b02559f95458 7e6478ca8575 6760fc732081 c2d543ff48ef 5a4c4a7bdea8 d47394ef0e3e 2e477ef44bd6 59a666c24e7e ee882a2be8be 5ba4c9614a46 b70a26c1c66b 0f081d942cc4 63c8d0fb185d e623292b7424 08d46758aa93 8e25fcefe35a 7e88bf94c45e 3fd9d138f3ca a2c2fb831b68 6b2badc8c484 0de13b858a08 0c700841a291 a3c4b1a2c0f3 ec0873c2ed0c 36c8420970bf 8dd6838e3865 4743b54d6e63 455266b5d80d 63277f483b54 a29eb5c4d7b6 195f61f413ec 2a002e0e2e4c e05934ea81ff 0fcbc2614060 472dfda728ea 08cf9e93d702 dee7d23b29f7 7bdd36fcd750 d0a860521a45 20cbcc1616c8 36088e05dad1 3432ec568e94 b7040e1f37f9 1c89f3dc0d6a da5d5f5670b9 db8e30174c41 4365c266bd5c d4f5471b5c7c 1904a0bbcab6 8abddff2b66d 182323504c86 c07d646a958e b4786ebbfb1a cfa70e094de4 319f22ebcaa1 5bfe67c6b642 8283cc3fa8ba 663f2c7afd81 16cf4e96424b b1262a1d6302 00b78a0bc305 788013f8dad2 f04968f4567e 87e8b1ac800c 60fa67c15971 1f54fb7d5de2 ae34390c8760 84a35b637604 2d07ab3a427e f2304d3542c2 847849146b29 8f3150664da2 1d6e7083134f 85795bcfd34b deb5cb52fae5 0612821b171a acce88826bd1 c20fc2b06f76 524ee9504696 51d4de6e2555 4663389ae27b 1907d2f7a292 c93b7d270d7a 7677281951d1 ded84672a85a 0b255efc02b0 adbcc6c6eb7b 3381441e1924 9178b2904a38 a5202611b0d9 2c5633c668fb 320eee271658 560a61bd17ee 49462cf56216 4f837de215ac b464c4617531 e40f76b32fde 62686181aaca d9f80ee9a02c 40cdcf59b199 0e3e5a8eb229 62891c2e3037 ac6e02ad17f6 2cb49b932bd0 1a9667dc86a8 2ed0a9c47052 91ebb40f7649 c6095478503c ce979f6d097b 915d098911d7 b209b826e3e7 7112ee9e9d1e 20934650b4f7 d37766a0a576 4031fceea74a b999ab22ef20 92c336bb317d 9815b19849d9 e9ae09a0c2d4"
for COMMIT in $DROP_COMMITS; do
  sed -i -E "s/^pick ($COMMIT[0-9a-f]*) /noop \1 /g" $TODO
done

# Drop commits not used
DROP_COMMITS="Add non-mainline source for rtl8192cu wireless driver version
rtl8192c_rf6052\: PHY_RFShadowRefresh\(\)\: fix off-by-one
rtl8192cu\: Add PID for D-Link DWA 131
Added Device IDs for August DVB-T 205
pinctrl-bcm2835\: Fix cut-and-paste error in \"pull\" parsing
net\: fix bridge multicast packet checksum validation
clk\: bcm2835\: add locking to pll\*\_on\/off methods
clk\: bcm2835\: pll_off should only update CM\_PLL\_ANARST
clk\: bcm2835\: divider value has to be 1 or more
clk\: bcm2835\: Fix PLL poweron
Enable cfg80211 support
suppress spurious messages
Add #if for 3\.14 kernel change \(#87\)
Set dev_type to wlan
Tentatively added support for more 8188CUS based devices\.
Add support for more 8188CUS and 8192CUS devices
Add ProductId for the Netgear N150 - WNA1000M
Fixes CONFIG_CONCURRENT_MODE CONFIG_MULTI_VIR_IFACES
Fixes compatibility with 3\.13
Enables warning in the compiler and fixes some issues, reference => https\:\/\/github\.com\/diederikdehaas\/rtl8812AU
Starts device in station mode instead of monitor, fixes NetworkManager issues
brcmfmac\: Plug memory leak in brcmf_fill_bss_param"

IFS=$'\n'
for COMMIT in $DROP_COMMITS; do
  sed -i -E "s/^pick ([0-9a-f]+) ($COMMIT.*)/noop \1 \2/g" $TODO
done
