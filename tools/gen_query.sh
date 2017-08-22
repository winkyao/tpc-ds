#!/bin/bash
if [ ! -d "queries" ]; then
	mkdir queries
fi

for i in `ls ../query_templates/query*`; 
do
	b=`basename $i`
	name=${b%.*}
	./dsqgen -template `basename $i` -directory ../query_templates -input ../query_templates/templates.lst -dialect netezza -scale 1
	mv ./query_0.sql ./queries/$name.sql
done
