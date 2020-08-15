package com.itheima.crm.settings.service.impl;

import com.itheima.crm.settings.dao.UserDao;
import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
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
        String now = DateTimeUtil.getSysTime();
        if (now.compareTo(expireTime)>0) return false;

        //状态为锁定,验证不通过
        if ("0".equals(lockState)) return false;

        //IP地址不允许,验证不通过
        return allowIps.contains(ip);
    }
}
