package com.itheima.crm.workbench.web.controller;

import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.pojo.Clue;
import com.itheima.crm.workbench.pojo.Tran;
import com.itheima.crm.workbench.service.ActivityService;
import com.itheima.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/Clue")
public class ClueController {

    @Autowired
    private UserService userService;

    @Autowired
    private ClueService clueService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping("/getUserList")
    @ResponseBody
    public List<User> getUserList(){
        return userService.getUsers();
    }

    @RequestMapping("/save")
    @ResponseBody
    public Boolean saveClue(Clue clue, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        clue.setId(UUIDUtil.getUUID());
        clue.setCreateBy(user.getName());
        clue.setCreateTime(DateTimeUtil.getSysTime());
        return clueService.save(clue);
    }

    @RequestMapping("/detail")
    public ModelAndView getDetailById(String id){
        Clue clue = clueService.getDetailById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/static/workbench/clue/detail.jsp");
        mv.addObject("clue",clue);
        return mv;
    }

    @RequestMapping("/showActivityListByCid")
    @ResponseBody
    public List<Activity> showActivityListByCid(String clueId){
        return activityService.showActivityListByCid(clueId);
    }

    @RequestMapping("/unbundByClueActivityRelationId")
    @ResponseBody
    public Boolean unbundByClueActivityRelationId(String clueActivityRelationId){
        return clueService.unbundByClueActivityRelationId(clueActivityRelationId);
    }

    @RequestMapping("/getActivityListByNameAndNotByClueId")
    @ResponseBody
    public List<Activity> getActivityListByNameAndNotByClueId(String name,String clueId){
        return activityService.getActivityListByNameAndNotByClueId(name,clueId);
    }

    @RequestMapping("/bund")
    @ResponseBody
    public Boolean bund(String cid,String[] aid){
        return clueService.bund(cid,aid);
    }

    @RequestMapping("/getActivityListByName")
    @ResponseBody
    public List<Activity> getActivityListByName(String name){
        return activityService.getActivityListByName(name);
    }

    @RequestMapping("/convert")
    public String convert(Tran tran, String clueId, String flag,String activityId,
                          HttpSession session){
        //当前登录的用户,设置创建人
        User user = (User) session.getAttribute("user");
        String createBy = user.getName();
        Boolean tranflag = "a".equals(flag);

        if (tranflag){
            //需要创建交易    (临时创建,在交易模块其他字段可修改补全)
            tran.setId(UUIDUtil.getUUID());
            tran.setCreateBy(createBy);
            tran.setCreateTime(DateTimeUtil.getSysTime());
            tran.setActivityId(activityId);
            //查看
            System.out.println(tran);
        }


            //传参 cluId 必须传
            //tran也得传,因为tran已经被SpringMVC创建
            //无法通过tran是否为null判断是否需要创建交易,所以再传递一个flag
            //因为转换业务需要用到大量的新增操作,创建人属性在session域中service取不到,需要传递

        Boolean flag1 =clueService.convert(clueId,tran,tranflag,createBy);
        if (flag1){
            return "redirect:/static/workbench/clue/index.jsp";
        }
        return null;

    }
}