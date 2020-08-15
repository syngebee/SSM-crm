package com.itheima.crm.settings.controller;

import com.itheima.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class myController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    @ResponseBody
    public String login(){
        return null;
    }
}
