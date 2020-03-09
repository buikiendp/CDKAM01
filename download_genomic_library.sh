#!/bin/bash

# CDKAM, Classification tool using Discriminative K-mers and Approximate Matching strategy
# Copyright 2019-2020
# Author: Bui Van-Kien (buikien.dp@sjtu.edu.cn)  
# Department of Bioinformatics and Biostatistics, Shanghai Jiao Tong University

# The downloading reference genome scripts are referred from Kraken2
# Copyright 2013-2019, Derrick Wood <dwood@cs.jhu.edu>

set -u  # Protect against uninitialized vars.
set -e  # Stop on error
set -o pipefail  # Stop on failures in non-final pipeline commands

MASKER="dustmasker"
if ! which $MASKER > /dev/null; then
  echo "Unable to find $MASKER in path, can't mask low-complexity sequences"
  exit 1
fi

LIBRARY_DIR="$CDKAM_DB_NAME"
NCBI_SERVER="ftp.ncbi.nlm.nih.gov"
FTP_SERVER="ftp://$NCBI_SERVER"
RSYNC_SERVER="rsync://$NCBI_SERVER"
THIS_DIR=$PWD

library_name="$1"
ftp_subdir=$library_name
library_file="library.fna"

function download_file() {
  file="$1"
  if [ -n "$CDKAM_USE_FTP" ]
  then
    wget -q ${FTP_SERVER}${file}
  else
    rsync --no-motd ${RSYNC_SERVER}${file} .
  fi
}


case $library_name in
  "archaea" | "bacteria" | "viral" | "fungi" |  "human")
	if [ ! -e "$LIBRARY_DIR/$library_name.txt" ]; then
		echo "Downloading $library_name data:"
		mkdir -p $LIBRARY_DIR/$library_name
		mkdir -p $LIBRARY_DIR/$library_name/references
		cd $LIBRARY_DIR/$library_name
		rm -f assembly_summary.txt
		remote_dir_name=$library_name
		
		if ! download_file "/genomes/refseq/$remote_dir_name/assembly_summary.txt"; then
		  1>&2 echo "Error downloading assembly summary file for $library_name, exiting."
		  exit 1
		fi

		rm -rf all/ library.f* manifest.txt rsync.err
		rsync_from_ncbi.pl assembly_summary.txt 
		scan_fasta_file.pl $library_file >> premap.txt
		
		echo "Step 3/4: Masking low-complexity regions..."
		if [ ! -e "$library_file.masked" ]; then
		  $MASKER -in $library_file -outfmt fasta | sed -e '/^>/!s/[a-z]/x/g' > "$library_file.tmp"
		  mv "$library_file.tmp" "$library_file"
		  touch "$library_file.masked"
		fi
		echo "Masking done."
		
		
		
		cd ..
		cd ..
		echo "Step 4/4: Creating full taxonomy..."
		./src/genSpecies $LIBRARY_DIR/$library_name/premap.txt $LIBRARY_DIR/taxonomy/nodes.dmp $LIBRARY_DIR/$library_name/$library_file $LIBRARY_DIR/$library_name
		cd $LIBRARY_DIR
		cat $library_name.txt >> targets.txt
		rm $library_name/$library_file
		echo "DONE."
		
	else
		echo "$library_name.txt existed."
	fi
    ;;
esac

