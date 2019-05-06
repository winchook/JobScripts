#!/bin/bash
#设置天数
ndate=15

#数据库账号
dbuser=admin

#数据库密码
dbpassword=password

#数据库名称
dbname=app

#表名称
tablename=t_app

#生成ndate天前的日期，如：2018-07-19
datestr=`date -d "-$ndate day" +%Y-%m-%d`

#SQL语句
delSqlStr="DELETE FROM $dbname.$tablename WHERE date<='$datestr' and id<>3 and id<>14"

#执行SQL语句
/usr/bin/mysql -u$dbuser -p$dbpassword $dbname -e "$delSqlStr"
