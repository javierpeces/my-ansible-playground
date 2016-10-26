#!/bin/bash
#
# walk thru words of a phrase checking for existence
#

frutas="sandia melón pera manzana plátano"
hoy=melón

for item in ${frutas}
do
    echo $item
    test "$item" == "$hoy" \
        && { echo ">>> $hoy FOUND!"; } \
        || { echo "    $hoy NOT FOUND!"; }
done
