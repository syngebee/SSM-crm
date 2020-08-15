package com.itheima.crm.settings.service;

import com.itheima.crm.settings.pojo.User;

public interface UserService {
    Boolean login(String loginAct ,String loginPwd,String ip);
}
