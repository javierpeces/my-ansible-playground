#!/bin/bash
#
# walk thru array checking for presence
# sequence version
#

frutas=(sandia melón pera manzana plátano)
total=${#frutas[@]}

echo "La lista tiene ${total} elementos"
hoy=melón

for i in $(seq 0 ${total})
do
    item=${frutas[${i}]}
    echo "El elemento ${i} contiene ${item}"
    test "$item" == "$hoy" \
        && { echo ">>> $hoy FOUND!"; } \
        || { echo "    $hoy NOT FOUND!"; }
done
