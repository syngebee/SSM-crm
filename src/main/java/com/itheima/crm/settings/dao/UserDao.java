package com.itheima.crm.settings.dao;

import com.itheima.crm.settings.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {
    User login(@Param("name") String name , @Param("loginPwd") String loginPwd);
}