# CDKAM, Classification tool using Discriminative K-mers and Approximate Matching strategy
Copyright 2019-2020
Author: Bui Van-Kien (buikien.dp@sjtu.edu.cn)  
Department of Bioinformatics and Biostatistics, Shanghai Jiao Tong University


1) Introduction

CDKAM is a new metagenome sequence classification tool for the third generation sequencing data with high error rates

2) Requirements

Linux operation system, memory 50 GB, disk space 120 GB

Perl 5.8.5 (or up) and g++ 6.4.0 (or up).

Dustmasker https://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/lxr/source/src/app/dustmasker/. 

It is suggested to install BLAST+ (ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/), which has already included dustmasker
Low-complexity sequences, e.g. "ACACACACACACACACA", "ATATATATATATATATAT" are known to occur in many different organisms and are typically less informative for use in alignments; 
The masked regions are not processed further by CDKAM.

Datasets can be found at OneDrive: https://1drv.ms/u/s!AvI5WFKEnJrGcNO2PkmiFgBz3lk?e=r0zJXU

3) Installation

First, download the zipped package of the latest CDKAM release:
$ wget https://github.com/buikiendp/CDKAM

Second, uncompress the package:
$ tar -xzvf 

Go in the extracted sub-directory "CDKAM". 
Finally:

$ ./install.sh

4) Running

Downloading database:
./download --standard --db $DBname

Building database:
./build_database.sh $DBname

Run classification:
./CDKAM.sh $DBname input output --fastq

If you have any questions, feel free to contact us:
   buikien.dp@sjtu.edu.cn
   ccwei@sjtu.edu.cn
   
