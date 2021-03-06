package com.itheima.crm.settings.dao;

import com.itheima.crm.settings.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserDao {
    User login(@Param("loginAct") String loginAct , @Param("loginPwd") String loginPwd);

    List<User> getUsers();

}
