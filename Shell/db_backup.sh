#!/bin/bash
#
save_days=7
back_dir=/data/imbak/database
innobackupex --defaults-file=/etc/my.cnf --socket=/data/mysql/mysql.sock  --user=admin  --password='password'  --stream=tar $back_dir  |pigz  > $back_dir/`date +%F_%H-%M-%S`.tar.gz
find $back_dir -mtime +$save_days -exec rm -rf {} \;
