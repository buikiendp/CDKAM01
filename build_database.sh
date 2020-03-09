#!/bin/bash
#
# CDKAM, Classification tool using Discriminative K-mers and Approximate Matching strategy
# Copyright 2019-2020
# Author: Bui Van-Kien (buikien.dp@sjtu.edu.cn)  
# Department of Bioinformatics and Biostatistics, Shanghai Jiao Tong University
#

DBDR=$1
RANK=0
FSCRPT=$(readlink -f "$0")
LDIR=$(dirname "$FSCRPT")

if [ $# -lt 1 ]; then
	echo "Usage: $0 <DTB path> "
	exit
fi

$LDIR/buildDB $LDIR/$1/targets.txt $LDIR/$1/nameFamily.txt $LDIR/$1/database_full.txt
$LDIR/uniqueDB $LDIR/$1/database_full.txt $LDIR/$1/database
rm $LDIR/$1/database_full.txt
