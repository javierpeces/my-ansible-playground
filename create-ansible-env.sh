#!/bin/bash

IFS=$'\n'
DEBUG=1
SELF=$(basename $0 .sh)

say( ) {
        phrase=$*
        test "${DEBUG}" == "1" && echo -e "${SELF}: ${phrase}"
}

#
#·············································································
# ansible common environment
#·············································································
#

basedir="${HOME}/play"
idcust="common"
idenv="one"
fullpath=${basedir}/${idcust}-${idenv}
say "\tenv: ${idenv} make fullpath: ${fullpath}"
test -d ${fullpath} || mkdir -p ${fullpath}

#
#·············································································
# ansible environment for a sample customer named "Banco Malo" / "Bad Bank"
#·············································································
#

idcust="malo"
idenvs=(prod test qauat devel)
roles=(common virtmach webserv appserv mdbserv qpseerv)
folders=(tasks handlers templates files vars defaults meta)

#
#·············································································
# do not edit below
#·············································································
#

say "customer: ${idcust}"
for idenv in ${idenvs[*]}
do
	fullpath=${basedir}/${idcust}-${idenv}
	say "\tenv: ${idenv} make fullpath: ${fullpath}"
	test -d ${fullpath} || mkdir ${fullpath}
done

#
#·············································································
# group_vars, host_vars, roles
#·············································································
#

for idenv in ${idenvs[*]}
do
	say "\tcust: ${idcust} env: ${idenv} make group_vars"
        mkdir -p ${basedir}/${idcust}-${idenv}/group_vars

	say "\tcust: ${idcust} env: ${idenv} make host_vars"
        mkdir -p ${basedir}/${idcust}-${idenv}/host_vars

	say "\tcust: ${idcust} env: ${idenv} make roles"
        mkdir -p ${basedir}/${idcust}-${idenv}/roles

	for role in ${roles[*]}
	do
        	say "\t\trole: ${role}"
		mkdir ${basedir}/${idcust}-${idenv}/roles/${role}
		for folder in ${folders[*]}
		do
        		say "\t\t\tfolder: ${folder}"
			mkdir ${basedir}/${idcust}-${idenv}/roles/${role}/${folder}
		done
	done
done
