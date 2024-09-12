#!/bin/bash

	ifaces=$(ifconfig  | sed 's/[ \t].*//;/^\(lo\|\)$/d')
	time_now=$(date +%T)
	time_date=$(date +%d/%m/%Y)
	for INTERFACE in $ifaces;
		do
		R1=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
		T1=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
		sleep 1
		R2=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
		T2=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
		TXPPS=$(awk "BEGIN {print ($T2 - $T1)/125}")
		RXPPS=$(awk "BEGIN {print ($R2 - $R1)/125}")
		echo $time_date,$time_now,RX,${INTERFACE},$(awk "BEGIN {print $RXPPS/1000}"),TX,${INTERFACE},$(awk "BEGIN {print $TXPPS/1000}")


	done
 #sed 's/\r//' bitrate.sh > bitrate_fixed.sh
