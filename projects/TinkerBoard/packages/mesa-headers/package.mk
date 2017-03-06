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

PKG_NAME="mesa-headers"
PKG_VERSION="$(get_pkg_version mesa)"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/${PKG_VERSION%-*}/mesa-$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="mesa-$PKG_VERSION*"
PKG_NEED_UNPACK="$ROOT/packages/graphics/mesa/package.mk"
PKG_DEPENDS_TARGET=""
PKG_SECTION="graphics"
PKG_SHORTDESC="mesa: 3-D graphics library with OpenGL API"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API which is very similar to that of OpenGL*. To the extent that Mesa utilizes the OpenGL command syntax or state machine, it is being used with authorization from Silicon Graphics, Inc. However, the author makes no claim that Mesa is in any way a compatible replacement for OpenGL or associated with Silicon Graphics, Inc. Those who want a licensed implementation of OpenGL should contact a licensed vendor. While Mesa is not a licensed OpenGL implementation, it is currently being tested with the OpenGL conformance tests. For the current conformance status see the CONFORM file included in the Mesa distribution."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
 : # nothing todo
}

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR ../include/CL $SYSROOT_PREFIX/usr/include
    cp -PR ../include/EGL $SYSROOT_PREFIX/usr/include
    cp -PR ../include/GL $SYSROOT_PREFIX/usr/include
    cp -PR ../include/GLES $SYSROOT_PREFIX/usr/include
    cp -PR ../include/GLES2 $SYSROOT_PREFIX/usr/include
    cp -PR ../include/GLES3 $SYSROOT_PREFIX/usr/include
}
