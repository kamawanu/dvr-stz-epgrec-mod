#!/bin/bash -e
export PATH=/usr/local/bin:$PATH

__MODE__=$( cat $0.TYPE )
if [ 0$SID -lt 10000 ]
then
	__MODE__=pt1 # override
fi

__PATH__=$0.$__MODE__
if [ \! -f $__PATH__ ]
then
	echo "$__PATH__" > "$OUTPUT"
	exit 9
fi
( 
bash $__PATH__ $* 2>&1 
) > "$OUTPUT".log
[ -s "$OUTPUT" ] || rm "$OUTPUT".log
chmod a+r "$OUTPUT"
