#!/bin/bash
#
# sample demo: test vs if/else
#

magnate="Felipe"
obrero="Anguita"

test "${magnate}" == "Felipe" && echo "Es el hombre de la pasta"
test "${obrero}" != "Anguita" || echo "Programa Programa Programa"

if [ "${magnate}" == "Felipe" ]
then
	echo "Ese gran magnate de los negocios internacionales"
else
	echo "Me confunde con otro"
fi
