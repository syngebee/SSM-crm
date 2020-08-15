package com.itheima.crm.settings.controller;

import com.itheima.crm.exception.LoginException;
import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class myController {

    @Autowired
    private UserService userService;

    @RequestMapping(value="/loginController",produces="text/plain;charset=utf-8")
    @ResponseBody
    public String login(String username, String password, HttpServletRequest req){
        HttpSession session = req.getSession();
        String ip = req.getRemoteAddr();
        try {
        User user = userService.login(username, password, ip);
//            User user = userService.login(username, password, "192.168.1.1");  //测试用
            session.setAttribute("usr",user);
            return "登录成功";
        } catch (LoginException e) {
            return e.getMessage();
        }
    }
}
