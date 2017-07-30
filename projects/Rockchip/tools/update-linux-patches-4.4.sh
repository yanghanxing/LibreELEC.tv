#!/bin/sh

SCRIPTPATH=$(dirname $0)
PKG_NAME=linux
eval $(grep "^  rockchip-4.4)" $SCRIPTPATH/../../../packages/$PKG_NAME/package.mk -A1 | grep PKG_VERSION)
PKG_BASE=$PKG_VERSION

if [ ! -d .git ]; then
  echo "ERROR: current path is not a git repository"
  exit 1
fi

rm -v 00*.patch
git format-patch $PKG_BASE --no-signature

mkdir -p $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4
rm -v $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-00*.patch

for f in 00*.patch; do
  mv -fv $f $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-$f
done

git format-patch rockchip-4.4..rockchip-4.4-cec --no-signature --stdout > $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-1000-cec.patch
git format-patch rockchip-4.4-vanilla..rockchip-4.4-macphy-fromlist --no-signature --stdout > $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-1000-macphy.patch
git format-patch rockchip-4.4..rockchip-4.4-pl330 --no-signature --stdout > $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-1000-pl330.patch
git diff rockchip-4.4..rockchip-4.4-lsk > $SCRIPTPATH/../patches/$PKG_NAME/rockchip-4.4/${PKG_NAME}-1000-lsk.patch
git format-patch rockchip-4.4..rockchip-4.4-tinker --no-signature --stdout > $SCRIPTPATH/../devices/TinkerBoard/patches/$PKG_NAME/${PKG_NAME}-1000-miniarm.patch
