package com.itheima.crm.settings.service;

import com.itheima.crm.settings.pojo.User;

public interface UserService {
    User login(String name ,String loginPwd);
}
