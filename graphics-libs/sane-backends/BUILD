create_group scanner &&

LDFLAGS="-pthread $LDFLAGS"

if [[ $USEFORK == y ]]; then
  OPTS="$OPTS --disable-pthread"
else
  OPTS="$OPTS --enable-pthread"
fi &&

if [[ $IPV6 == y ]]; then
  OPTS="$OPTS --enable-ipv6"
else
  OPTS="$OPTS --disable-ipv6"
fi &&

if [[ $HP5400NVSM == y ]]; then
  echo "patching HP5400 for NO_STRING_VERSION_MATCH"
  echo '#define NO_STRING_VERSION_MATCH
' >> $SOURCE_DIRECTORY/backend/hp5400_internal.h
fi &&

if [[ "$SANE_BUILD_LOCAL" == n ]]; then
  OPTS="$OPTS --disable-local-backends"
fi &&

OPTS="--disable-latex \
      --with-docdir=$INSTALL_ROOT/usr/share/doc/sane-backends \
      $OPTS" &&

default_build
