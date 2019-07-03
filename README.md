# osp10_commands

 [[ Comandos útiles para OSP10 ]]

Ejemplo ejecución:

[]$ bash -x tenant_quotas_filter.sh *[/path/output_file.log]*

[]$ bash -x tenant_in-use_quota.sh *[/path/tenant_ids_file]*

[]$ bash -x tenant_change_quota.sh *[/path/tenant_ids_file]* *[tenant_in-use_quota_$(date +%b-%d-%Y_%H%M).csv]*

Requisito de SW General: *python-openstackclient-3.8.1-1.el7ost.noarch*
