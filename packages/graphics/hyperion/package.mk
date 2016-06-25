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

PKG_NAME="hyperion"
PKG_VERSION="d2f4725"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tvdzwan/hyperion"
PKG_URL="https://github.com/hyperion-project/hyperion/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ninja:host Python libusb protobuf Qt4 rpi_ws281x"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="Hyperion: an AmbiLight controller"
PKG_LONGDESC="Hyperion is an modern opensource AmbiLight implementation."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

AMLOGIC_SUPPORT="-DENABLE_AMLOGIC=0"
DISPMANX_SUPPORT="-DENABLE_DISPMANX=0"
FB_SUPPORT="-DENABLE_FB=1"
X11_SUPPORT="-DENABLE_X11=0"
WS2812BPWM_SUPPORT="-DENABLE_WS2812BPWM=0"

if [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
  AMLOGIC_SUPPORT="-DENABLE_AMLOGIC=1"
elif [ "$KODIPLAYER_DRIVER" = "bcm2835-driver" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"
  DISPMANX_SUPPORT="-DENABLE_DISPMANX=1"
  FB_SUPPORT="-DENABLE_FB=0"
  WS2812BPWM_SUPPORT="-DENABLE_WS2812BPWM=1"
elif [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xorg-server"
  X11_SUPPORT="-DENABLE_X11=1"
fi

pre_build_target() {
  cp -a $(get_build_dir rpi_ws281x)/* $ROOT/$PKG_BUILD/dependencies/external/rpi_ws281x
}

configure_target() {
  if [ "$DEBUG" = yes ]; then
    CMAKE_BUILD_TYPE="Debug"
  else
    CMAKE_BUILD_TYPE="Release"
  fi

  echo "" > ../cmake/FindGitVersion.cmake
  cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
        -DQT_QMAKE_EXECUTABLE=$SYSROOT_PREFIX/usr/bin/qmake \
        -DHYPERION_VERSION_ID="$PKG_VERSION" \
        $AMLOGIC_SUPPORT \
        $DISPMANX_SUPPORT \
        $FB_SUPPORT \
        -DENABLE_OSX=0 \
        -DUSE_SYSTEM_PROTO_LIBS=ON \
        -DENABLE_SPIDEV=1 \
        -DENABLE_TINKERFORGE=0 \
        -DENABLE_V4L2=1 \
        $WS2812BPWM_SUPPORT \
        -DENABLE_WS281XPWM=1 \
        $X11_SUPPORT \
        -DENABLE_QT5=0 \
        -DENABLE_TESTS=0 \
        -Wno-dev \
        ..
}

make_target() {
  ninja -j$CONCURRENCY_MAKE_LEVEL
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PRv bin/hyperiond $INSTALL/usr/bin
    cp -PRv bin/hyperion-remote $INSTALL/usr/bin
    cp -PRv bin/hyperion-v4l2 $INSTALL/usr/bin

  if [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
    cp -PRv bin/hyperion-aml $INSTALL/usr/bin
    cp -PRv bin/hyperion-framebuffer $INSTALL/usr/bin
  elif [ "$KODIPLAYER_DRIVER" = "bcm2835-driver" ]; then
    cp -PRv bin/hyperion-dispmanx $INSTALL/usr/bin
  elif [ "$DISPLAYSERVER" = "x11" ]; then
    cp -PRv bin/hyperion-x11 $INSTALL/usr/bin
    cp -PRv bin/hyperion-framebuffer $INSTALL/usr/bin
  fi

  mkdir -p $INSTALL/usr/share/services
    cp -PRv $PKG_DIR/default.d/*.json $INSTALL/usr/share/services

  mkdir -p $INSTALL/usr/share/hyperion/effects
    cp -PRv ../effects/* $INSTALL/usr/share/hyperion/effects

  mkdir -p $INSTALL/opt/hyperion
    ln -sf /usr/share/hyperion/effects $INSTALL/opt/hyperion/effects
}

post_install() {
  enable_service hyperion-defaults.service
  enable_service hyperion.service
}
