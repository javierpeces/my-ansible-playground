#!/bin/bash
#
# simply get centos
#
BASE="http://ftp.cixug.es/CentOS/5.11/isos/x86_64"
PREF="CentOS-5.11-x86_64-bin-DVD"
DEST=~/dld/linux/centos/5.11

test -z "$DEST" && exit 1

for FILE in ${PREF}-1to2.torrent ${PREF}-1of2.iso ${PREF}-2of2.iso 
do
	echo wget -O ${DEST}/${PREF}-${FILE} ${BASE}/${PREF}-${FILE}
done

# eof
