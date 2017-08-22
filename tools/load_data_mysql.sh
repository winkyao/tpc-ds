#!/bin/bash
set -e

CURDIR=$(cd `dirname $0`; pwd)
cd $CURDIR

load_data() {
	ls $CURDIR/data/*.dat | while read file; do
		pipe=$file.pipe
		mkfifo $pipe
		table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
		echo $file $table
		LANG=C && sed -e 's_^|_\\N|_g' -e 's_||_|\\N|_g' -e 's_||_|\\N|_g' $file > $pipe & \
		mysql -u root --local-infile -Dtpcds -e \
          	"load data local infile '$pipe' into table $table character set latin1 fields terminated by '|';"
		rm -f $pipe
	done
}
load_data
