create_account ratbox &&

OPTS="--with-confdir=$INSTALL_ROOT/etc/$SPELL \
       --with-rundir=$INSTALL_ROOT/var/run/ircd \
       --with-logdir=$INSTALL_ROOT/var/log/$SPELL \
      --with-helpdir=$INSTALL_ROOT/usr/share/$SPELL/help \
    --with-moduledir=$INSTALL_ROOT/usr/lib/$SPELL/modules \
      --with-nicklen=$IRCD_RATBOX_NICKLEN \
                     $IRCD_RATBOX_OPTS \
                     $OPTS" &&

make_single &&
default_build &&
make_normal
