#!/bin/bash
# C-time:2018-11-09
# 用法：/bin/bash release_ftpc.sh -c release-20190502-1432.zip
show_usage="args: [-c] [--code=]"
opt_code=""
GETOPT_ARGS=`getopt -o c: -al code: -- "$@"`
eval set -- "$GETOPT_ARGS"
# show opts
while [ -n "$1" ]
do
  case "$1" in
    -c|--code) opt_code=$2; shift 2;;
    --) break ;;
    *) echo $1,$2,$show_usage; break ;;
  esac
done

if [[ -z $opt_code ]]; then
  echo $show_usage
  echo "opt_code: $opt_code"
  exit 0
else
## Variables
R_dir=/data/update/xns-ftpc
M_dir=/data/update
passcode=yourpassword
username=root
ip=172.31.16.32
www_name=www
www_pack=/data/update/www
www_dir=/data/www
back_dir=/data/backup

## backup
cd /data
tar -zcf $back_dir/www_`date +%Y%m%d_%H%M%S`.tar.gz www
cd /data/tomcat/webapps/hz/views/
tar -zcf $back_dir/register_`date +%Y%m%d_%H%M%S`.tar.gz register
## Logic
rm -rf ${M_dir}/*
sshpass -p $passcode scp -r $username@$ip:${R_dir}/${opt_code} ${M_dir}/

## Local Operation
cd ${M_dir} && unzip -q ${opt_code}
if [ ! -d "${www_pack}" ];then
    echo "${www_pack} is not exist!"
    exit 1
else
    \cp -r ${www_name}/* ${www_dir}/
fi
\cp -r hz/views/register/* /data/tomcat/webapps/hz/views/register/
## Change Own
chown -R web.web ${www_dir}
echo -e '\033[32m虚拟区-PC部署完成,请验证!\033[0m'
echo -e '\033[32m'${opt_code}'\033[0m'
rm -rf ${M_dir}/*
fi
