package com.itheima.crm.workbench.web.controller;

import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.service.ActivityService;
import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @RequestMapping("/save")
    @ResponseBody
    public Boolean saveActivity(Activity a, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        a.setId(UUIDUtil.getUUID());
        a.setCreateTime(DateTimeUtil.getSysTime());
        a.setCreateBy(user.getName());

        return activityService.save(a);
    }

    ///Activity/pageList
    @RequestMapping("/pageList")
    @ResponseBody
    public PaginationVO pageList(ActivityRequestDTO aDto){
        int skipCount = (aDto.getPageNo() - 1) * aDto.getPageSize();
        aDto.setSkipCount(skipCount);
        System.out.println(aDto);
        return activityService.pageList(aDto);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Boolean deleteActivity(String[]id){
        System.out.println(Arrays.toString(id));
        return activityService.delete(id);
    }

    @RequestMapping("/getUserListAndActivity")
    @ResponseBody
    public Map<String,Object> getUserListAndActivity(String id){
        System.out.println("进入处理");
        Map<String, Object> result = new HashMap<>();
        List<User> userList = userService.getUsers();
        result.put("userList",userList);
        Activity a = activityService.getActivityById(id);
        result.put("a",a);
        return result;
    }

    @RequestMapping("/update")
    @ResponseBody
    public Boolean updateActivity(Activity a){
        //修改时间
        a.setEditTime(DateTimeUtil.getSysTime());
        return activityService.updateActivity(a);
    }

    @RequestMapping("/detail")
    public ModelAndView toDetail(String id){
        ModelAndView mv = new ModelAndView();
        Activity a =activityService.getDetail(id);
        System.out.println(a);
        mv.addObject("a",a);
        mv.setViewName("forward:/static/workbench/activity/detail.jsp");
        return mv;
    }
}
