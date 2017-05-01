#!/bin/bash -e
exec $0.$( cat $0.TYPE ) $*
