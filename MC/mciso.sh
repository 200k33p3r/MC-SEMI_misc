#! /bin/bash

TRACKS_RAW_DIR=/media/sf_share2/9.23/good
ISOMASTER_DIR=/home/zookeeper/Desktop/iso-master
TRACKS_DIR=$ISOMASTER_DIR/data/tracks
EEPS_DIR=$ISOMASTER_DIR/data/eeps
ISOS_DIR=$ISOMASTER_DIR/data/isochrones
OUTISO_DIR=/home/zookeeper/Desktop/workdir/9.23/outiso
NML_DIR=/home/zookeeper/Desktop/workdir/9.20/nml

namelist="inputmc"
#for folder in $(ls $TRACKS_RAW_DIR) ; do
	#clear data
#	cd $TRACKS_DIR
#	rm -f *
#	cd $EEPS_DIR
#	rm -f *
#	cd $TRACKS_RAW_DIR/$folder
#	for file in $(ls $TRACKS_RAW_DIR/$folder); do
#		#copy tracks to track_dir
#		if [[ ${file: -4:4} == "data" ]]; then
#            cp $file $TRACKS_DIR
#			var_num=${file: -9:4}
#			echo "$var_num"
#		fi
#	done
for var_num in $(seq 1200 1999); do
	cd $TRACKS_DIR
	rm -f *
	cd $EEPS_DIR
	rm -f *
	cd $TRACKS_RAW_DIR
	for file in $(ls $TRACKS_RAW_DIR) ; do
		if [[ ${file: -9:4} == $var_num ]]; then
			cp $file $TRACKS_DIR
		fi
	done
	#generate nml
	cd $NML_DIR
	if [[ -e $namelist ]]; then
		rm $namelist
	fi
	echo "#version string, max 8 characters " >$namelist
	echo "example " >>$namelist
	echo "#initial Y, initial Z, [Fe/H], [alpha/Fe], v/vcrit (space separated) " >>$namelist
	echo "   0.2426  1.89e-03   -1.50        0.40     0.0" >>$namelist
	echo "#data directories: 1) history files, 2) eeps, 3) isochrones" >>$namelist
	echo "$TRACKS_DIR" >>$namelist
	echo "$EEPS_DIR" >>$namelist
	echo "$ISOS_DIR" >>$namelist
	echo "#read history_columns" >>$namelist
	echo "my_history_columns_basic.list" >>$namelist
	echo "#specify tracks" >>$namelist
	echo "21" >>$namelist
	echo "m0500.feh-150.${var_num}.data" >>$namelist
	echo "m0550.feh-150.${var_num}.data" >>$namelist
	echo "m0600.feh-150.${var_num}.data" >>$namelist
	echo "m0650.feh-150.${var_num}.data" >>$namelist
	echo "m0700.feh-150.${var_num}.data" >>$namelist
	echo "m0750.feh-150.${var_num}.data" >>$namelist
	echo "m0800.feh-150.${var_num}.data" >>$namelist
	echo "m0850.feh-150.${var_num}.data" >>$namelist
	echo "m0900.feh-150.${var_num}.data" >>$namelist
	echo "m0950.feh-150.${var_num}.data" >>$namelist
	echo "m1000.feh-150.${var_num}.data" >>$namelist
	echo "m1050.feh-150.${var_num}.data" >>$namelist
	echo "m1100.feh-150.${var_num}.data" >>$namelist
	echo "m1150.feh-150.${var_num}.data" >>$namelist
	echo "m1200.feh-150.${var_num}.data" >>$namelist
	echo "m1250.feh-150.${var_num}.data" >>$namelist
	echo "m1300.feh-150.${var_num}.data" >>$namelist
	echo "m1350.feh-150.${var_num}.data" >>$namelist
	echo "m1400.feh-150.${var_num}.data" >>$namelist
	echo "m1450.feh-150.${var_num}.data" >>$namelist
	echo "m1500.feh-150.${var_num}.data" >>$namelist
	echo "#specify isochrones" >>$namelist
	echo "isochrones_${var_num}.txt" >>$namelist
	echo "min_max" >>$namelist
	echo "linear" >>$namelist
	echo "14" >>$namelist
	echo "1e9" >>$namelist
	echo "1.4e10" >>$namelist
	#generate eeps and isochrones
	cp $namelist $ISOMASTER_DIR
	cd $ISOMASTER_DIR
	./make_eep $namelist
    ./make_iso $namelist
    cd $ISOS_DIR
    cp "isochrones_${var_num}.txt" $OUTISO_DIR
done