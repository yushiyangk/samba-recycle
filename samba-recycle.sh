#!/usr/bin/env bash

# Search .recycle subdirectory of samba shares and remove files older than
#  RECYCLE_AGE number of days, then remove all empty subdirectories
# RECYCLE_AGE is 28 by default if no argument is provided

# Yu Shiyang <yu.shiyang@gnayihs.uy>

RECYCLE_AGE=28
[ "$1" ] && {
	RECYCLE_AGE="$1"
}

grep -E '^path\s*=\s*.+' /etc/samba/smb.conf | sed 's/^path\s*=\s*//' | while read line; do
	if [ -d "$line/.recycle" ]; then
		find "$line/.recycle" -mindepth 1 -mtime +"$RECYCLE_AGE" ! -type d -delete
		find "$line/.recycle" -mindepth 1 -type d -empty -delete
	fi
done

