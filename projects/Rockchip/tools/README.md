# Tools

Helper scripts to update patches

Example usage:

```
# cat ~/.bash_aliases
alias build-tinker='cd ~/LibreELEC && PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm make image'
alias update-kodi='cd ~/kodi && ~/LibreELEC/projects/Rockchip/tools/update-kodi-patches.sh'
alias update-libmali='cd ~/libmali && ~/LibreELEC/projects/Rockchip/tools/update-libmali-patches.sh'
alias update-linux-4.4='cd ~/linux-rockchip && ~/LibreELEC/projects/Rockchip/tools/update-linux-patches-4.4.sh'
alias update-u-boot='cd ~/u-boot-rockchip && ~/LibreELEC/projects/Rockchip/tools/update-u-boot-patches.sh'
```
