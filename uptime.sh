#!/bin/bash
GATEWAY=`ip r s | grep default | cut -d' ' -f3`
INTERVAL=1
while true;
do
    STARTTIME=`date +%s`
    while ping -c 1 -W 1 ${GATEWAY} >/dev/null 2>&1; 
    do
	awk -v STIME="$STARTTIME" 'BEGIN {
                       DTIME=systime()-STIME;
                       printf "Seconds of uptime since %s: %d\n",
                       strftime("%a %b %e %H:%M:%S %Z %Y",STIME),
                       DTIME; }';
	sleep $INTERVAL;
    done
    echo "HOST DROPPED!"
done
