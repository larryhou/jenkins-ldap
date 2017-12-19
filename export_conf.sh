#!/bin/bash

file=${1}
if [ "${file}" = "" ]
then
	file=next.xml
fi

domain=next
echo "dn: dc=${domain},dc=com"
echo "objectClass: organization"
echo "objectClass: dcobject"
echo "o:Jenkins Development"
echo "dc: ${domain}"
echo

text=$(cat ${file})
echo ${text} | xmllint --xpath '//group/@name' - \
| sed $'s/ /\\\n/g' | sed '/^\s*$/d' | awk -F'"' '{print $2}' \
| while read group # Define Organization
do
	echo "dn: ou=${group},dc=${domain},dc=com"
	echo "objectclass: top"
	echo "objectclass: organizationalUnit"
	echo "ou: ${group}"
	echo
done

i=1
m=$(echo ${text} | xmllint --xpath 'count(//group)' -)
while [ ! ${i} -gt ${m} ]
do
	group_text=$(echo ${text} | xmllint --xpath "//group[${i}]" -)
	group_name=$(echo ${group_text} | xmllint --xpath "/group/@name" - | awk -F'"' '{print $2}')
	
	# Define User Group
	echo "dn: cn=${group_name},ou=${group_name},dc=${domain},dc=com"
	echo "objectclass: groupOfUniqueNames"
	echo "cn: ${group_name}"
	
	j=1
	n=$(echo ${group_text} | xmllint --xpath 'count(//user)' -)
	while [ ! ${j} -gt ${n} ]
	do
		name=$(echo ${group_text} | xmllint --xpath "//user[${j}]/@name" - | awk -F'"' '{print $2}')
		echo "uniqueMember: uid=${name},ou=${group_name},dc=${domain},dc=com"
		
		let j=j+1
	done
	echo
	
	j=1
	while [ ! ${j} -gt ${n} ] # Define Single User
	do
		name=$(echo ${group_text} | xmllint --xpath "//user[${j}]/@name" - | awk -F'"' '{print $2}')
		pssw=$(echo ${group_text} | xmllint --xpath "//user[${j}]/@pssw" - | awk -F'"' '{print $2}')
		
		echo "dn: uid=${name},ou=${group_name},dc=${domain},dc=com"
		echo "uid: ${name}"
		echo "objectclass: person"
		echo "objectclass: inetOrgPerson"
		echo "objectclass: organizationalPerson"
		echo "mail: ${name}@gmail.com"
		echo "userPassword: ${pssw}"
		echo "sn: ${name}"
		echo "cn: ${name}"
		echo
		
		let j=j+1
	done
	
	let i=i+1
done