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

PKG_NAME="Python"
PKG_VERSION="2.7.13"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.python.org/"
PKG_URL="http://www.python.org/ftp/python/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="zlib:host bzip2:host sqlite:host"
PKG_DEPENDS_TARGET="toolchain sqlite expat zlib bzip2 libressl libffi Python:host"
PKG_SECTION="lang"
PKG_SHORTDESC="python: The Python programming language"
PKG_LONGDESC="Python is an interpreted object-oriented programming language, and is often compared with Tcl, Perl, Java or Scheme."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="ac_cv_prog_HAS_HG=/bin/false \
                         ac_cv_prog_SVNVERSION=/bin/false \
                         --enable-static \
                         --without-cxx-main \
                         --disable-sqlite3 \
                         --disable-tk \
                         --with-expat=builtin \
                         --disable-curses \
                         --disable-codecs-cjk \
                         --disable-nis \
                         --enable-unicodedata \
                         --disable-dbm \
                         --disable-gdbm \
                         --disable-bsddb \
                         --disable-test-modules \
                         --disable-bz2 \
                         --disable-ssl \
                         --disable-ossaudiodev \
                         --disable-pyo-build"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_file_dev_ptc=no \
                           ac_cv_file_dev_ptmx=yes \
                           ac_cv_func_lchflags_works=no \
                           ac_cv_func_chflags_works=no \
                           ac_cv_func_printf_zd=yes \
                           ac_cv_buggy_getaddrinfo=no \
                           ac_cv_header_bluetooth_bluetooth_h=no \
                           ac_cv_header_bluetooth_h=no \
                           ac_cv_file__dev_ptmx=no \
                           ac_cv_file__dev_ptc=no \
                           ac_cv_have_long_long_format=yes \
                           ac_cv_working_tzset=yes \
                           ac_cv_prog_HAS_HG=/bin/false \
                           ac_cv_prog_SVNVERSION=/bin/false \
                           --with-expat=system \
                           --disable-bsddb \
                           --enable-sqlite3 \
                           --enable-ssl \
                           --disable-codecs-cjk \
                           --enable-unicodedata \
                           --enable-unicode=ucs4 \
                           --enable-bz2 \
                           --enable-zlib \
                           --disable-ossaudiodev \
                           --without-cxx-main \
                           --without-doc-strings \
                           --with-system-ffi \
                           --disable-pydoc \
                           --disable-test-modules \
                           --disable-gdbm \
                           --disable-tk \
                           --disable-nis \
                           --disable-dbm \
                           --disable-pyo-build \
                           --disable-pyc-build"

post_patch() {
  # This is needed to make sure the Python build process doesn't try to
  # regenerate those files with the pgen program. Otherwise, it builds
  # pgen for the target, and tries to run it on the host.
    touch $PKG_BUILD/Include/graminit.h
    touch $PKG_BUILD/Python/graminit.c
}

pre_configure_host() {
  export CPPFLAGS="$CPPFLAGS -I$ROOT/$TOOLCHAIN/include"
  export LDFLAGS="$LDFLAGS -Wl,--enable-new-dtags"
}

make_host() {
  make -j1 $PKG_MAKE_OPTS_HOST
}

post_makeinstall_target() {
  EXCLUDE_DIRS="lib2to3 ensurepip config compiler distutils sysconfigdata unittest"
  for dir in $EXCLUDE_DIRS; do
    rm -rf $INSTALL/usr/lib/python*/$dir
  done
  rm -rf $INSTALL/usr/lib/python*/lib-dynload/sysconfigdata

  rm -rf $INSTALL/usr/bin/2to3
  rm -rf $INSTALL/usr/bin/smtpd.py
  rm -rf $INSTALL/usr/bin/python*-config

  cd $INSTALL/usr/lib/python2.7
  python -Wi -t -B $ROOT/$PKG_BUILD/Lib/compileall.py -d /usr/lib/python2.7 -f .
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -f {} \; &>/dev/null

  # strip
  chmod u+w $INSTALL/usr/lib/libpython*.so.*
  debug_strip $INSTALL/usr
}
