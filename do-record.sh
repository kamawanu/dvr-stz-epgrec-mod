#!/bin/sh
echo "CHANNEL : $CHANNEL"
echo "DURATION: $DURATION"
echo "OUTPUT  : $OUTPUT"
echo "TUNER : $TUNER"
echo "TYPE : $TYPE"
echo "MODE : $MODE"
echo "SID  : $SID"

RECORDER="/usr/local/bin/node /usr/local/bin/rivarun"
#TYPE=GR

if [ ${MODE} = 0 ]; then
   # MODE=0では必ず無加工のTSを吐き出すこと
   RECORDER="/usr/bin/tclsh $HOME/rivarunclone.tcl"
   $RECORDER --priority 1 --ch $TYPE/$CHANNEL $DURATION "${OUTPUT}" 
	echo $?
elif [ ${MODE} = 1 ]; then
   # 目的のSIDのみ残す
   $RECORDER --priority 1 --b25 --sid $SID --ch $TYPE/$CHANNEL $DURATION "${OUTPUT}" || /usr/local/bin/recpt1 --b25 --ch $TYPE/$CHANNEL $DURATION "${OUTPUT}" 
	echo $?
# mode 2 example is as follows
#   ffmpeg -i ${OUTPUT}.tmp.ts ... 適当なオプション ${OUTPUT}
fi
