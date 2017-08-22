#!/bin/bash

run() {
CURDIR=$(cd `dirname $0`; pwd)
OUTDIR=$CURDIR/$1
cd $CURDIR

if [ -e $OUTDIR ]; then
  rm -rf $OUTDIR
fi 

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

for file in `ls selected_queries/*.sql`; do
	sql_file=`basename $file`
	bname=${sql_file%.*}
	start=$(date +%s)
	timeout 3m mysql -u root -h 127.0.0.1 -P 4000 -Dtpcds < $file > $OUTDIR/$bname.out 2> $OUTDIR/$bname.err
	end=$(date +%s)
	elapsed=$(( $end - $start ))
	echo "elapsed time: $elapsed s" >> $OUTDIR/$bname.out
	if [ $? -ne "0" ]; then
		echo $file
	fi
done
}

if [ $# -eq 0 ]; then
	run tidb_r
else 
	run $*
fi
