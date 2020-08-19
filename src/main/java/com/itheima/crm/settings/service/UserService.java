package com.itheima.crm.settings.service;


import com.itheima.crm.exception.LoginException;
import com.itheima.crm.settings.pojo.User;

import java.util.List;

public interface UserService {
    User login(String loginAct , String loginPwd, String ip) throws LoginException;

    List<User> getUsers();

    List<User> getUserNames();
}
