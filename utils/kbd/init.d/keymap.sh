#!/bin/bash

PROGRAM=/bin/loadkeys
RUNLEVEL=S
NEEDS="+local_fs"
RECOMMENDED=yes

. /etc/init.d/smgl_init
. /etc/sysconfig/keymap
. /etc/sysconfig/devices

dropfile=/var/tmp/keymap.drop

start()
{
  [[ "$TTY_NUMS" ]] && [[ "$SETFONT_ARGS" ]] &&
    required_executable /bin/setfont
  [[ "$KEYMAP$INCLUDEMAPS" ]] &&
    required_executable /bin/loadkeys

  if [[ "$KEYMAP" ]]; then
    echo "$(/bin/loadkeys $KEYMAP 2>&1)"
    evaluate_retval
  fi

  for a in $INCLUDEMAPS; do
    [[ $(find /usr/share/kbd/keymaps/ -type f -name "$a.inc*" 2>/dev/null) ]] &&
    [[ ! $(find /usr/share/kbd/keymaps/ -type f -name "$a.map*" 2>/dev/null) ]] &&
      a="$a.inc"
    echo "$(/bin/loadkeys $a 2>&1)"
    evaluate_retval
  done

  [[ "$DEVICES" == "devfs" ]] && DEV_TTY="vc/" || DEV_TTY="tty"

  if [[ "$UNICODE_START" ]]; then
    required_executable /bin/unicode_start
    /bin/kbd_mode -u
    /bin/dumpkeys | /bin/loadkeys --unicode
  fi

  if [[ "$TTY_NUMS" == '*' ]]; then
    TTY_NUMS=
    for a in $(grep ^tty.*: /etc/inittab); do
      TTY_NUMS="$TTY_NUMS $(expr "$a" : 'tty\([0-9]*\):.*')"
    done
  fi

  for n in $TTY_NUMS; do
    echo "Loading settings for $DEV_TTY$n..."
    [[ "$UNICODE_START" ]] && /bin/echo -ne "\033%G" > /dev/$DEV_TTY$n
    if [[ "$SETFONT_ARGS" ]]; then
      /bin/setfont $SETFONT_ARGS -C /dev/$DEV_TTY$n
      evaluate_retval
    fi
  done

  [[ -f $dropfile ]] && rm $dropfile
  STATUS_VARS="KEYMAP INCLUDEMAPS SETFONT_ARGS TTY_NUMS UNICODE_START DEV_TTY"
  for a in $STATUS_VARS; do
    /bin/echo "$a=\"${!a}\"" >> $dropfile
  done
}

stop()
{
  [[ "$TTY_NUMS" ]] && [[ "$SETFONT_ARGS" ]] &&
    required_executable /bin/setfont

  [[ -f $dropfile ]] && . $dropfile && rm $dropfile

  [[ "$KEYMAP$INCLUDEMAPS" ]] &&
    required_executable /bin/loadkeys &&
    echo "$(/bin/loadkeys defkeymap 2>&1)"

  [[ "$UNICODE_START" ]] &&
    required_executable /bin/unicode_stop &&
    /bin/kbd_mode -a

  for n in $TTY_NUMS; do
    echo "Unloading settings for $DEV_TTY$n..."
    [[ "$UNICODE_START" ]] && /bin/echo -ne '\033%@' > /dev/$DEV_TTY$n
    if [[ "$SETFONT_ARGS" ]]; then
      /bin/setfont default8x16 -C /dev/$DEV_TTY$n
      evaluate_retval
    fi
  done
}

status()
{
  if [[ ! -f $dropfile ]]; then
    echo "No status info available."
    return 1
  fi

  . $dropfile

  echo "KEYMAP=\"$KEYMAP\""
  echo "INCLUDEMAPS=\"$INCLUDEMAPS\""
  echo "SETFONT_ARGS=\"$SETFONT_ARGS\""
  echo "TTY_NUMS=\"$TTY_NUMS\""
  echo "UNICODE_START=\"$UNICODE_START\""
}
