#!/bin/bash
#
# walk thru array ckecking for presence
# 'in' version
#

frutas=(sandia melón pera manzana plátano)
hoy=melón

for item in ${frutas[*]}
do
    echo $item
    test "$item" == "$hoy" \
        && { echo ">>> $findthis FOUND!"; } \
        || { echo "    $findthis NOT FOUND!"; }
done
