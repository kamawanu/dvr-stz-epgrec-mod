#!/bin/bash -e
bash $0.$( cat $0.TYPE ) $*
chmod a+r $OUTPUT
