#!/bin/bash

select_query() {
    CURDIR=$(cd `dirname $0`; pwd)
    cd $CURDIR

    for file in `ls tidb_r/*.out`; do
        cnt=`cat $file | wc -l`
	idx=${file%.*}
	idx=${idx#"tidb_r/query"}
        if [ $cnt -gt 1 ]; then
	    #echo $idx
            #echo $file
            #tail -n 1 $file
	    echo "query$idx.sql"
	    #cp queries/query$idx.sql selected_queries/
        fi
    done
}

select_query
