#!/bin/sh

case $1 in
  add)
    smbpasswd -a $2
    ;;
  delete)
    smbpasswd -x $2
    ;;
  enable)
    smbpasswd -e $2
    ;;
  disable)
    smbpasswd -d $2
    ;;
  *)
    echo "Usage: $0 add <username>"
    exit 1
    ;;
esac
