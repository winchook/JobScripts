#!/bin/sh
#
### demonstration opts
show_usage="args: [-c , -b , -p , -s] [--code=, --build-path=, --pub-path=, --sn=]"
### opts display
# platform code
opt_code=""

# building dir
opt_buildpath=""

# publishing dir
opt_pubpath=""

# publishing sn
opt_sn=""

GETOPT_ARGS=`getopt -o c:b:p:s: -al code:,build-path:,pub-path:,sn: -- "$@"`
eval set -- "$GETOPT_ARGS"
# show opts
while [ -n "$1" ]
do
        case "$1" in
                -c|--code) opt_code=$2; shift 2;;
                -b|--build-path) opt_buildpath=$2; shift 2;;
                -p|--pub-path) opt_pubpath=$2; shift 2;;
                -s|--sn) opt_sn=$2; shift 2;;
                --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done

if [[ -z $opt_code || -z $opt_buildpath || -z $opt_pubpath || -z $opt_sn ]]; then
        echo $show_usage
        echo "opt_code: $opt_code , opt_buildpath: $opt_buildpath , opt_pubpath: $opt_pubpath , opt_sn: $opt_sn"
        exit 0
else
        # define the base dir
        BASE_WWW_PATH="/data/www"
        BACKUP_PATH="/data/backup"
        OPS_DATE=`date +%Y-%m-%d-%H:%M:%S`
        BACKUP_FILE="www_$opt_sn"
        LOG_PATH="/data/logs"
        LOG_FILE=publish.log

        # mkdir dir
        mkdir -p ${BASE_WWW_PATH} ${BACKUP_PATH} ${LOG_PATH}

        # backup static files function
        function backup(){
               if [ ! -d "${BACKUP_PATH}" ];then
                     echo -e "\033[33m${BACKUP_PATH} is not exist.\033[0m"
                     exit 1
               else
                     echo " " >> ${LOG_PATH}/${LOG_FILE}
                     echo "$OPS_DATE" >> ${LOG_PATH}/${LOG_FILE}
                     echo "----------" >> ${LOG_PATH}/${LOG_FILE}
                     echo "Backup is start." >> ${LOG_PATH}/${LOG_FILE}
                     echo ">>>sn is $opt_sn" >> ${LOG_PATH}/${LOG_FILE}
                     \cp -r ${BASE_WWW_PATH} ${BACKUP_PATH}/${BACKUP_FILE}
                     echo -e "\033[35mBackup is done,file exist in ${BACKUP_PATH}/${BACKUP_FILE}\033[0m"
                     echo "Backup is done,file exist in ${BACKUP_PATH}/${BACKUP_FILE}" >> ${LOG_PATH}/${LOG_FILE}
                     
               fi
        }

        # publish new files function
        function publish(){
               if [ ! -d "${opt_buildpath}" ];then
                     echo -e "\033[33m${opt_buildpath} is not exist.\033[0m"
                     exit 1
               else
                     echo "$OPS_DATE" >> ${LOG_PATH}/${LOG_FILE}
                     echo "----------" >> ${LOG_PATH}/${LOG_FILE}
                     echo "publish is start." >> ${LOG_PATH}/${LOG_FILE}
                     \cp -r ${opt_buildpath} $opt_pubpath
                     echo -e "\033[35mPublish is done\033[0m"
                     echo "Publish is done." >> ${LOG_PATH}/${LOG_FILE}

               fi
        }

        # rollback the sn files function
        function rollback(){
               echo -e "\033[36mcccc\033[0m"
        }
        backup
        publish
        #rollback

fi
