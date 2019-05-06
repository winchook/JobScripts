#!/bin/bash
#define var
back_dir=/data/imbak
app_name=bms
tomcat_name=tomcat-admin
app_dir=/data/${tomcat_name}/webapps
update_dir=/data/ansible

#app back
cd ${app_dir}
tar -zcf $back_dir/${app_name}_`date +%Y%m%d_%H%M%S`.tar.gz ${app_name}

#release
cd ${update_dir}
unzip ${app_name}.zip
\cp -r ${app_name}/* ${app_dir}/${app_name}/
echo -e '\033[-BMS-部署完成,请验证!\033[0m'
echo -e '\033[32m'${opt_code}'\033[0m'
