create_group    at                                   &&
create_account  at                                   &&

SENDMAIL='#define  SENDMAIL  "/usr/sbin/sendmail"'   &&

./configure  --build=$BUILD                          \
             --prefix=${INSTALL_ROOT}/usr            \
             --sysconfdir=${INSTALL_ROOT}/etc        \
             --localstatedir=${INSTALL_ROOT}/var     \
             --bindir=${INSTALL_ROOT}/bin            \
             --sbindir=${INSTALL_ROOT}/sbin          \
             --mandir=${INSTALL_ROOT}/usr/share/man  \
             --with-daemon_username=at               \
             --with-daemon_groupname=at              \
             $OPTS                                   &&

echo  "$SENDMAIL"  >>  config.h                      &&

make_single &&
make &&
make_normal
