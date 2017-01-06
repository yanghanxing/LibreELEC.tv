################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="samba"
PKG_VERSION="4.4.9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.samba.org"
PKG_URL="http://samba.org/samba/ftp/stable/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib connman Python heimdal:host"
PKG_SECTION="network"
PKG_SHORTDESC="samba: The free SMB / CIFS fileserver and client"
PKG_LONGDESC="Samba is a SMB server that runs on Unix and other operating systems. It allows these operating systems (currently Unix, Netware, OS/2 and AmigaDOS) to act as a file and print server for SMB and CIFS clients. There are many Lan-Manager compatible clients such as LanManager for DOS, Windows for Workgroups, Windows NT, Windows 95, Linux smbfs, OS/2, Pathworks and more."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME

  strip_gold

  echo "Checking uname machine type: \"$TARGET_ARCH\"" >>$ROOT/$PKG_BUILD/cache.txt
  python_LDFLAGS="" \
  python_LIBDIR="" \
  ./buildtools/bin/waf configure \
    --prefix=/usr \
    --sysconfdir=/etc \
	--with-privatelibdir=/usr/lib \
    --localstatedir=/var \
    --with-libiconv=$SYSROOT_PREFIX/usr \
    --enable-fhs \
    --cross-compile \
    --cross-answers=$ROOT/$PKG_BUILD/cache.txt \
    --hostcc=$HOST_CC \
    --disable-rpath \
    --disable-rpath-install \
	--disable-rpath-private-install \
    --disable-iprint \
    --without-pam \
    --without-dmapi \
    --disable-glusterfs \
    --without-cluster-support \
    --bundled-libraries='!asn1_compile,!compile_et' \
    --without-ad-dc \
    --without-acl-support \
    --without-ldap \
    --without-ads \
    --without-regedit \
    --without-ntvfs-fileserver
}

make_target() {
  : # ./buildtools/bin/waf --targets=smbclient
}

makeinstall_target() {
  ./buildtools/bin/waf install --destdir=$SYSROOT_PREFIX --targets=smbclient
  ./buildtools/bin/waf install --destdir=$INSTALL --targets=smbclient

  rm -r $INSTALL/usr/bin
  rm -r $INSTALL/usr/lib/python2.7
  rm -r $INSTALL/usr/share
}
