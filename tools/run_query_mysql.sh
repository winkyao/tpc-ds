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
	timeout 3m mysql -u root -Dtpcds < $file > $OUTDIR/$bname.out
	end=$(date +%s)
	elapsed=$(( $end - $start ))
	echo "elapsed time: $elapsed s" >> $OUTDIR/$bname.out
	if [ $? -ne "0" ]; then
		echo $file
	fi
done
}

if [ $# -eq 0 ]; then
	run mysql_r
else 
	run $*
fi
