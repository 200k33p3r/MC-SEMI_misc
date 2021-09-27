#!/bin/bash

workdir=$1

cd $workdir
for file in $(ls $workdir) ; do
	dir_name=${file: 0:-4}
	mkdir $dir_name
	tar -xf $file -C $dir_name
	cd $dir_name
	gunzip -r *
	cd ..
done

#for file in $(ls $workdir); do
#	echo $file
#done