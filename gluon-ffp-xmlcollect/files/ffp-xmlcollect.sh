#!/bin/sh
## script variables
SCRIPTVERSION='24.08'
UPLOADHOST="status-in.freifunk-potsdam.de"
UPLOADPORT=17485

COLLDIR=/tmp/ffp_coll

SCRIPTNAME=$(basename "$0")

export LC_ALL=C

if [ ! -d "$COLLDIR" ]; then
	mkdir "$COLLDIR"
fi

nodeid=$(sed 's/://g' /lib/gluon/core/sysconfig/primary_mac)
hostname=$(uci get system.@system[0].hostname)
time=$(date +%s)

xnodeinfo() {
	echo "<nodeinfo>"
	gluon-neighbour-info -d ::1 -p 1001 -r "nodeinfo"
	echo "</nodeinfo>"
}

xneighbours() {
	echo "<neighbours>"
	gluon-neighbour-info -d ::1 -p 1001 -r "neighbours"
	echo "</neighbours>"
}

xstatistics() {
	echo "<statistics>"
	gluon-neighbour-info -d ::1 -p 1001 -r "statistics"
	echo "</statistics>"
}

xconn() {
	echo "<conn>"
	sed 's/  */ /g' /proc/net/nf_conntrack | cut -d' ' -f 1-4 | sort | uniq -c | sed 's/^ *//g'
	echo "</conn>"
}

xroutes() {
	echo "<routes>"
	ip route show table main | grep "^default"
	ip -6 route show table main | grep "^default"
	echo "</routes>"
}

fupload() {
	if [ -f "$1" ]; then
		len=$(du -b "$1" | cut -f1)
		(
			echo "$len $(basename "$1") $hostname"
			cat "$1"
		) | nc "$2" "$3" &
		p=$!
		sleep 10 && kill $p 2> /dev/null
	fi
}

plog() {
	MSG="$*"
	#echo ${MSG}
	logger -t "${SCRIPTNAME}" "${MSG}"
}

upload_rm() {
	if [ -f "$1" ]; then
		plog "uploading $1..."
		res=$(fupload "$1" "$UPLOADHOST" "$UPLOADPORT")
		if [ "$res" = "success" ]; then
			rm "$1"
		fi
	fi
}

upload_rm_or_gzip() {
	if [ -f "$1" ]; then
		plog "uploading $1..."
		res=$(fupload "$1" "$UPLOADHOST" "$UPLOADPORT")
		if [ "$res" = "success" ]; then
			rm "$1"
		else
			plog "uploading $1 failed, zipping..."
			gzip "$1" 2> /dev/null
		fi
	fi
}

if [ "$1" = "collect" ]; then
	m=$(date +%M | sed 's/^0//')
	f=$COLLDIR/$time.cff
	echo "<ffgstat nodeid='$nodeid' host='$hostname' time='$time' ver='$SCRIPTVERSION'>" > "$f"
	(
		xneighbours
		xstatistics
		xconn
		if [ $(( $m % 10 )) -eq 0 ]; then
			xnodeinfo
			xroutes
		fi
	) >> "$f"
	echo "</ffgstat>" >> "$f"
	mv "$f" "$f.xml"
	rm -r "$COLLDIR"/*.cff 2> /dev/null
elif [ "$1" = "upload" ]; then
	find "$COLLDIR" -type f -mmin +$(( $(cut -d'.' -f1 /proc/uptime) / 60 )) -exec rm {} \;
	i=100
	for f in "$COLLDIR"/*.cff.xml.gz; do
		upload_rm "$f" &
		sleep 1
		i=$(( i - 1 ))
		if [ "$i" -eq 0 ]; then
		    break
		fi
	done
	for f in "$COLLDIR"/*.cff.xml; do
		upload_rm_or_gzip "$f" &
		sleep 1
	done
	wait
	filled=$(df "$COLLDIR" | tail -n1 | sed -E 's/^.*([0-9]+)%.*$/\1/g')
	while [ "$filled" -gt 50 ]; do
		f=$(find "$COLLDIR" -type f | sort -r | head -n1)
		if [ "$f" != "" ]; then
			rm "$f"
		else
			break
		fi
	done
fi
