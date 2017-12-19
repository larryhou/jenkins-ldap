#!/bin/bash
cd $(dirname ${0})

# killall slapd
sudo rm -fr /var/db/openldap.next/openldap-data/*

sh export_conf.sh > next.ldif

svn add --force .
svn commit -m 'Update LDAP accounts' --force-log .

sudo slapadd -f /etc/openldap.next/slapd.conf -v -l next.ldif

sudo /usr/libexec/slapd -f /etc/openldap.next/slapd.conf -h ldap://localhost:8744 -d3