#!/bin/bash

## $1 = "/ruta/archivo_de_salida.*"

## Obtener credenciales de Administrador con archivo keytonerc_*
source ~/keystonerc_admin

## Filtrar el nombre de Tenant + Quotas (valores especificos) y vaciar resultado en archivo en parametro de entrada $1
#/usr/bin/openstack project list | grep -v Name | for i in $(awk -F '|' '{ printf $2 }'); \
#do echo ; echo -n "Tenant Name:"; openstack project show $i | grep -i name | awk -F '|' '{ printf $3 }'; \
#echo; openstack quota show $i | egrep -w 'floating-ips|instances|networks|routers|volumes|gigabytes|project' \
#| egrep -v 'per-volume|backup' ; done >> $1

## Filtrar el nombre de Tenant + Quotas (todos los valores) y vaciar resultado en archivo en parametro de entrada $1
/usr/bin/openstack project list | grep -v Name | for i in $(awk -F '|' '{ printf $2 }'); \
do echo ; echo -n "Tenant Name:"; openstack project show $i | grep -i name | awk -F '|' '{ printf $3 }'; \
echo; openstack quota show $i; done >> $1
