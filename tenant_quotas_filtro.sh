#!/bin/bash

## Pasar primer parametro a variable output_file (archivo donde se guardara la salida del filtro)
$1 = output_file

## Obtener credenciales de Administrador con archivo keytonerc_*
source ~/keystonerc_admin

## Filtrar el nombre de Tenant + Quotas y vaciar resultado en archivo tenant_quotas.out
/usr/bin/openstack project list | grep -v Name | for i in $(awk -F '|' '{ printf $2 }'); \
do echo ; echo -n "Tenant Name:"; openstack project show $i | grep -i name | awk -F '|' '{ printf $3 }'; \
echo; openstack quota show $i | egrep -w 'floating-ips|instances|networks|routers|volumes|gigabytes|project' \
| egrep -v 'per-volume|backup' ; done >> $output_file
