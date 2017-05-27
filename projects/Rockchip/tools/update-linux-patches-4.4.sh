#!/bin/sh

SCRIPTPATH=$(dirname $0)
PKG_NAME=linux
PKG_BASE=origin/release-4.4

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
