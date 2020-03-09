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

if [ $# -lt 4 ]; then
	echo "Usage: $0 <DTB path> <input> <output> <--fasta/--fastq>"
	exit
fi

$LDIR/classify $LDIR/$1/database $LDIR/$1/nameFamily.txt $2 $3 $4

