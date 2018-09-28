#!/bin/sh

case $1 in
  add)
    addgroup -g $3 $2
    adduser -s /bin/false -H -D -u $3 -G $2 $2
    smbpasswd -a $2
    ;;
  *)
    echo "Usage: $0 add <username>"
    exit 1
    ;;
esac
