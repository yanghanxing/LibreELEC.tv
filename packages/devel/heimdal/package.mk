################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="heimdal"
PKG_VERSION="1.6rc2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.h5l.org/"
PKG_URL="http://www.h5l.org/dist/src/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="heimdal: The Heimdal Kerberos 5, PKIX, CMS, GSS-API, SPNEGO, NTLM, Digest-MD5 and, SASL implementation."
PKG_LONGDESC="Heimdal is an implementation of Kerberos 5 (and some more stuff) largely written in Sweden (which was important when we started writing it, less so now). It is freely available under a three clause BSD style license."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="
  --disable-shared
  --enable-static
  --without-openldap
  --without-capng
  --without-sqlite3
  --without-libintl
  --without-openssl
  --without-berkeley-db
  --without-readline
  --without-libedit
  --without-hesiod
  --without-x
  --disable-heimdal-documentation
"

makeinstall_host() {
  cp lib/asn1/asn1_compile $ROOT/$TOOLCHAIN/bin/

  # compile_et is not built if it already exists
  if [ -f lib/com_err/compile_et ]; then
    cp lib/com_err/compile_et $ROOT/$TOOLCHAIN/bin/
  fi
}
