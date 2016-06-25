################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="bcm2835-userland"
PKG_VERSION="0147f98"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="https://github.com/raspberrypi/userland/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="userland-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_LONGDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$DEBUG" = yes ]; then
  CMAKE_BUILD_TYPE="Debug"
else
  CMAKE_BUILD_TYPE="Release"
fi

configure_target() {
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
        -DVMCS_INSTALL_PREFIX=/usr \
        ..
}

post_makeinstall_target() {
  rm -rf $INSTALL/etc
  rm -rf $INSTALL/usr/bin/containers_*
  rm -rf $INSTALL/usr/bin/dtoverlay-*
  rm -rf $INSTALL/usr/bin/raspi*
  rm -rf $INSTALL/usr/bin/vchiq_test
  rm -rf $INSTALL/usr/lib/plugins
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/usr/src
}
