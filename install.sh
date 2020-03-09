#!/bin/bash
#
# CDKAM, Classification tool using Discriminative K-mers and Approximate Matching strategy
# Copyright 2019-2020
# Author: Bui Van-Kien (uikien.dp@sjtu.edu.cn)  
# Department of Bioinformatics and Biostatistics, Shanghai Jiao Tong University
#

FSCRPT=$(readlink -f "$0")
LDIR=$(dirname "$FSCRPT")

echo |cpp -fopenmp -dM |grep -i open > $LDIR/.tmp
NB=`wc -l < $LDIR/.tmp`



g++ -o $LDIR/src/genSpecies $LDIR/src/genSpecies.cpp -O3
g++ -o $LDIR/src/buildDB  $LDIR/src/compress.cpp -O3
g++ -o $LDIR/src/uniqueDB  $LDIR/src/DTB_unique.cpp -O3
g++ -o $LDIR/src/classify  $LDIR/src/classify.cpp -O3

mv $LDIR/src/buildDB $LDIR/
mv $LDIR/src/uniqueDB $LDIR/
mv $LDIR/src/classify $LDIR/

