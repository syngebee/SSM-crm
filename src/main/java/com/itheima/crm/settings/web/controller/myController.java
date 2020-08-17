package com.itheima.crm.settings.web.controller;

import com.itheima.crm.exception.LoginException;
import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class myController {

    @Autowired
    private UserService userService;

//    @RequestMapping(value="/loginController",produces="text/plain;charset=utf-8")
    @ResponseBody
    @RequestMapping(value="/controller/loginController")
    public Map<String,Object> login(String username, String password, HttpServletRequest req){
        //获取session对象
        HttpSession session = req.getSession();

        //获取客户端ip 传递service层做校验
        String ip = req.getRemoteAddr();

        //返回对象Map
        Map<String, Object> map = new HashMap<>();

        //初始化提示信息内容为"" 成功状态为false
        String msg="";
        Boolean flag = false;

        //抓取service层抛出的异常 --后期全局异常处理类咋办?
        try {
//            User user = userService.login(username, password, "192.168.1.1");  //测试用,ip地址写死
            User user = userService.login(username, password, ip);

            //没报异常, user塞入session,更改成功状态
            session.setAttribute("user",user);
            flag=true;

        } catch (LoginException e) {
            //修改提示信息内容
            msg=e.getMessage();
        }

        map.put("msg",msg);
        map.put("success",flag);
        return map;
    }
}
