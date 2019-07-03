#!/bin/bash

for i in $(cat $1); do openstack quota set --instances $(grep $i $2 | \
awk -F "," '{ printf $3 }') --gigabytes $(grep $i $2 | awk -F "," '{ printf $5 }') --volumes \
$(grep $i $2| awk -F "," '{ printf $7 }') --floating-ips $(grep $i $2 | awk -F "," '{ printf $9 }') --networks \
$(grep $i $2 | awk -F "," '{ printf $11 }') $i; done
