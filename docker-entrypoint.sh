#!/bin/bash

set -eo pipefail
shopt -s nullglob

/usr/sbin/nslcd

exec "$@"
