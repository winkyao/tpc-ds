#!/bin/bash
for i in `ls ./query_templates/query*`;
do
echo "define _END= \"\";" >> $i
done
