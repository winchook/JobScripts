#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
env_list = ['release']
pack_name = 'release-20190502-1432.zip'
for env_name in env_list:
    os.system("/bin/bash /data/script/%s.sh -c %s" % (env_name,pack_name))
