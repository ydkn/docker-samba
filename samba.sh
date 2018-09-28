#!/bin/sh

nmbd -D
smbd -F -S --no-process-group </dev/null
