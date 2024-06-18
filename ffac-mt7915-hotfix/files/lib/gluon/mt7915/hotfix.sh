#!/bin/sh
logger -t "ffac-mt7915-hotfix" -p debug "reloading wifi firmware now"
rmmod mt7915e
modprobe mt7915e
wifi
