if    [  -e  ${INSTALL_ROOT}/etc/httpd/httpd.conf   ];  then
  SPELL_ROOT=`grep  '^DocumentRoot'  ${INSTALL_ROOT}/etc/httpd/httpd.conf   |  cut  -d\"  -f2`
elif  [  -e  ${INSTALL_ROOT}/etc/httpsd/httpd.conf  ];  then
  SPELL_ROOT=`grep  '^DocumentRoot'  ${INSTALL_ROOT}/etc/httpsd/httpd.conf  |  cut  -d\"  -f2`
fi                                                                       &&

if  [  "${SPELL_ROOT}"  ==  ""  ];  then
  SPELL_ROOT=/usr/share
fi                                                                       &&
[ -f ${INSTALL_ROOT}${SPELL_ROOT}/${SPELL}/inc/settings.ini ]		 &&
cp  -ruv  ${INSTALL_ROOT}${SPELL_ROOT}/${SPELL}/inc/settings.ini /tmp    &&

echo  "${SPELL} previous inc/settings.ini was copied over to /tmp"         
true
