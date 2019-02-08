#!/bin/sh
#
### demonstration opts
show_usage="args: [-s] [--sn=]"
### opts display
# publishing sn
opt_sn=""

GETOPT_ARGS=`getopt -o s: -al sn: -- "$@"`
eval set -- "$GETOPT_ARGS"
# show opts
while [ -n "$1" ]
do
        case "$1" in
                -s|--sn) opt_sn=$2; shift 2;;
                --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done

if [[ -z $opt_sn ]]; then
        echo $show_usage
        echo "opt_sn: $opt_sn"
        exit 0
else
        # define the base dir
        BASE_WWW_PATH="/data/www"
        BACKUP_PATH="/data/backup"
        OPS_DATE=`date +%Y-%m-%d-%H:%M:%S`
        BACKUP_FILE="www_$opt_sn"
        LOG_PATH="/data/logs"
        LOG_FILE=publish.log

        # rollback the sn files function
        function rollback(){
               if [ ! -d "${BACKUP_PATH}" ];then
                     echo -e "\033[33m${BACKUP_PATH} is not exist.\033[0m"
                     exit 1
               else
                     echo " " >> ${LOG_PATH}/${LOG_FILE}
                     echo "$OPS_DATE" >> ${LOG_PATH}/${LOG_FILE}
                     echo "----------" >> ${LOG_PATH}/${LOG_FILE}
                     echo "Rollback is start." >> ${LOG_PATH}/${LOG_FILE}
                     echo ">>>sn is $opt_sn" >> ${LOG_PATH}/${LOG_FILE}
                     \cp -r ${BACKUP_PATH}/${BACKUP_FILE}/* ${BASE_WWW_PATH}
                     echo -e "\033[35mRollback is done.\033[0m"
                     echo "Rollback is done" >> ${LOG_PATH}/${LOG_FILE}
                     
               fi
        }

        rollback

fi
