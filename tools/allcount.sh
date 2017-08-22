#!/bin/bash
CURDIR=$(cd `dirname $0`; pwd)
cd $CURDIR

ls $CURDIR/data/*.dat | while read file; do
	table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
	echo "select count(*) $table from $table;"
done
