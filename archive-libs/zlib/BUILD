OPTS="--eprefix=$INSTALL_ROOT $OPTS" &&

CFLAGS="$CFLAGS -DPIC -fPIC"    &&
CFLAGS="${CFLAGS/-O?/-O3} -fno-tree-vectorize -mstackrealign -DUNALIGNED_OK" &&

sedit  "s/-O/$CFLAGS/"  Makefile                   &&

./configure  --prefix=${TRACK_ROOT}/usr  \
             --shared \
                $OPTS                         &&

make DESTDIR=$INSTALL_ROOT &&
cd $SOURCE_DIRECTORY.static &&
./configure --prefix=${TRACK_ROOT}/usr \
            $OPTS &&

make prefix=${INSTALL_ROOT}/usr
