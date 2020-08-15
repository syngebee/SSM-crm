package com.itheima.crm.settings.service.impl;

import com.itheima.crm.settings.dao.UserDao;
import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userdao;

    @Override
    public Boolean login(String loginAct, String loginPwd,String ip) {

        User user = userdao.login(loginAct, loginPwd);
        String lockState=null;
        String expireTime=null;
        String allowIps=null;
        //空值判断
        if(user==null) return false;
        if ((lockState=user.getLockState())==null) return false;
        if ((expireTime=user.getExpireTime())==null) return false;
        if ((allowIps=user.getAllowIps())==null) return false;


        //失效时间大于现在时间, 验证不通过
        if (expireTime.compareTo(new Date().toString())>0) return false;

        //状态为锁定,验证不通过
        if (lockState.equals("0")) return false;

        //IP地址不允许,验证不通过
        String[] ips = allowIps.split(",");
        Boolean result = false;
        for (String s : ips) {
            if (ip.equals(s)) result=true;
        }
        return result;
    }
}
