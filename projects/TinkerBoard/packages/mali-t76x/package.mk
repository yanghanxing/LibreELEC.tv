################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

if [ -z "$MALI_WINSYS" ]; then
  echo "Please add MALI_WINSYS to your project or device options file, aborting."
  exit 1
fi

PKG_NAME="mali-t76x"
PKG_VERSION="r12p0-04rel0"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/user-space"
PKG_URL="http://malideveloper.arm.com/downloads/drivers/binary/$PKG_VERSION/mali-t76x_${PKG_VERSION}_linux_1+$MALI_WINSYS.tar.gz"
PKG_SOURCE_DIR="$MALI_WINSYS"
PKG_DEPENDS_TARGET="mesa-headers"
PKG_SECTION="graphics"
PKG_SHORTDESC="mali-t76x: OpenGL ES user-space binary for the ARM Mali Midgard GPU family"
PKG_LONGDESC="mali-t76x: OpenGL ES user-space binary for the ARM Mali Midgard GPU family"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
 : # nothing todo
}

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR *.so* $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
    cp -PR *.so* $INSTALL/usr/lib
}
