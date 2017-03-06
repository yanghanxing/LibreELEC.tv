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

PKG_NAME="mpv"
PKG_VERSION="7924492"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://mpv.io/"
PKG_URL="https://github.com/LongChair/mpv/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ffmpeg libass libdrm alsa libva-rockchip-driver mpp"
PKG_SECTION="multimedia"
PKG_SHORTDESC="mpv: Video player based on MPlayer/mplayer2"
PKG_LONGDESC="mpv: mpv is a media player based on MPlayer and mplayer2. It supports a wide variety of video file formats, audio and video codecs, and subtitle types."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-libsmbclient --disable-apple-remote --prefix=/usr \
                           --enable-drm --enable-gbm --enable-egl-drm --enable-vaapi-drm --enable-rkmpp"

configure_target() {
  cd $ROOT/$PKG_BUILD
    ./bootstrap.py
	CFLAGS="-D__GBM__ -DMESA_EGL_NO_X11_HEADERS" ./waf configure $PKG_CONFIGURE_OPTS_TARGET
}

make_target() {
  cd $ROOT/$PKG_BUILD
    ./waf build
}

makeinstall_target() {
  cd $ROOT/$PKG_BUILD
    ./waf install --destdir=$INSTALL
}
