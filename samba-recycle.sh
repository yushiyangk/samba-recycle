#!/usr/bin/env bash

# Search .recycle subdirectory of samba shares and remove files older than 14 days
#  then remove all empty subdirectories

# Yu Shiyang <yu.shiyang@gnayihs.uy>

grep -E '^path\s*=\s*.+' /etc/samba/smb.conf | sed 's/^path\s*=\s*//' | while read line; do
	if [ -d "$line/.recycle" ]; then
		find "$line/.recycle" -mindepth 1 -mtime +14 -delete
		find "$line/.recycle" -mindepth 1 -type d -empty -delete
	fi
done
