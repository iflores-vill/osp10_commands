#!/bin/bash

source ~/admin_v3

output_file=tenant_in-use_quota_$(date +%b-%m-%Y:%H%M).csv

echo "Tenant Name, Tenant ID, in-use Instances, quota Instances, in-use Gigabytes, quota Gigabytes, in-use Volumes, quota Volumes, in-use FIPs, quota FIPs, in-use Networks, quota Networks" > $output_file

for tenant_id in $(cat $1); do \
in_use_instances=$(nova quota-show --detail --tenant $tenant_id | grep instances | awk -F ":" '{ printf $4 }' | awk -F "}" '{ printf $1 }'); \
quota_instances=$(nova quota-show --detail --tenant $tenant_id | grep instances | awk -F ":" '{ printf $2 }' | awk -F "," '{ printf $1 }'); \
in_use_gigabytes=$(cinder quota-usage $tenant_id | grep -w gigabytes | awk -F "|" '{ printf $3 }' | awk '{ printf $1 }'); \
quota_gigabytes=$(cinder quota-usage $tenant_id  | grep -w gigabytes | awk -F "|" '{ printf $5 }' | awk '{ printf $1 }'); \
in_use_volumes=$(cinder quota-usage $tenant_id  | grep -w volumes | awk -F "|" '{ printf $3 }' | awk '{ printf $1 }'); \
quota_volumes=$(cinder quota-usage $tenant_id  | grep -w volumes | awk -F "|" '{ printf $5 }' | awk '{ printf $1 }'); \
in_use_fips=$(openstack floating ip list | grep -i $tenant_id | wc -l); \
quota_fips=$(openstack quota show $tenant_id | grep -w floating-ips | awk -F "|" '{ printf $3 }'| awk '{ printf $1 }'); \
in_use_networks=$(neutron net-list | grep $tenant_id | wc -l); \
quota_networks=$(openstack quota show $tenant_id | grep -w networks | awk -F "|" '{ printf $3 }'| awk '{ printf $1 }'); \
echo "$(openstack project show $tenant_id | grep -i name | awk -F '|' '{ printf $3 }'|awk '{ printf $1 }'), $tenant_id, $in_use_instances, $quota_instances, $in_use_gigabytes, $quota_gigabytes, $in_use_volumes, $quota_volumes, $in_use_fips, $quota_fips, $in_use_networks, $quota_networks" >> $output_file; done
