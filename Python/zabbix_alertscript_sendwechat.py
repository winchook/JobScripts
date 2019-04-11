#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import json
import sys
class weChat:
    def __init__(self,Corpid,Secret): 
        url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s' % (Corpid,Secret)
        res = self.url_req(url)
        self.token = res["access_token"]
    def url_req(self,url):
        req = requests.get(url)
        res = json.loads(req.text)
        return res
 
    def send_message(self,user,content): 
        url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % self.token
        data = { 
                "touser": user, 
                "msgtype": "text", 
                "agentid": 1, 
                "text": { 
                        "content": content
                        }, 
                "safe":"0" 
                }
 
        res = requests.post(url,json=data)
        if json.loads(res.content)['errmsg'] == 'ok':
            return "send message sucessed"
        else:
            return res
 
 
if __name__ == '__main__': 
    user = sys.argv[1]
    content = sys.argv[2]
    Corpid = 'user identified'
    Secret = 'user identified'
    get_token = weChat(Corpid,Secret)
    print get_token.send_message(user,content)
