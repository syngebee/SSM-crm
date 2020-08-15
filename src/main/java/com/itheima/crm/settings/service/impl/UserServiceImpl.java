package com.itheima.crm.settings.service.impl;

import com.itheima.crm.exception.LoginException;
import com.itheima.crm.settings.dao.UserDao;
import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userdao;

    @Override
    public User login(String loginAct, String loginPwd,String ip) throws LoginException {
        String md5Pwd = MD5Util.getMD5(loginPwd);

        User user = userdao.login(loginAct, md5Pwd);
        String expireTime=null;
        String allowIps=null;
        //空值判断
        if(user==null) throw new LoginException("用户名密码错误");


        //失效时间大于现在时间, 验证不通过
        expireTime=user.getExpireTime();
        String now = DateTimeUtil.getSysTime();
        if (expireTime==null || now.compareTo(expireTime)>0) throw new LoginException("该账号已失效,请联系管理员");

        //状态为锁定,验证不通过
        String lockState=user.getLockState();
        if ("0".equals(lockState)) throw new LoginException("此账号已锁定,请联系管理员");

        //IP地址不允许,验证不通过
        allowIps=user.getAllowIps();
        if (allowIps==null || !allowIps.contains(ip)) throw new LoginException("不被允许的IP地址,请联系管理员");

        return user;
    }
}
