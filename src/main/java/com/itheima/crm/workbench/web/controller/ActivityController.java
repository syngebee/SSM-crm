package com.itheima.crm.workbench.web.controller;

import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/Activity")
public class ActivityController {

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping("/getUserList")
    @ResponseBody
    public List<User> getUserListActivity(){
        return userService.getUsers();
    }

    @RequestMapping(value="/save")
    @ResponseBody
    public Boolean saveUser(Activity a, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        a.setId(UUIDUtil.getUUID());
        a.setCreateTime(DateTimeUtil.getSysTime());
        a.setCreateBy(user.getName());

        System.out.println(a);

        return activityService.save(a);

    }
}
