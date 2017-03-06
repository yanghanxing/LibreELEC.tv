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

PKG_NAME="libva-rockchip-driver"
PKG_VERSION="063cf2b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/vaapi"
PKG_URL="https://github.com/rockchip-linux/rockchip-va-driver/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="rockchip-va-driver-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libva libdrm"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libva-rockchip-driver: libva backend for rockchip v4l2 driver"
PKG_LONGDESC="libva-rockchip-driver: libva backend for rockchip v4l2 driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DCODEC_BACKEND=libvpu \
                       -DHAVE_VA_DRM=ON"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/va
    mv $INSTALL/usr/lib/dri/*.so $INSTALL/usr/lib/va
}
