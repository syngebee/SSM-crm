package com.itheima.crm.workbench.web.controller;

import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Tran")
public class TranController {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/add")
    public ModelAndView add(){
        ModelAndView mv = new ModelAndView();
        List<User> users = userService.getUsers();
        mv.addObject("uList",users);
        mv.setViewName("/static/workbench/transaction/save.jsp");
        return mv;
    }

    @RequestMapping("/getCustomerName")
    @ResponseBody
    public List<String> getCustomerName(String name){
        return customerService.getCustomerName(name);
    }

    @RequestMapping("/possibility")
    @ResponseBody
    public String getPossibility(String key, HttpServletRequest request){
        ServletContext servletContext = request.getServletContext();
        Map<String,String> pMap = (Map<String, String>) servletContext.getAttribute("pMap");
        return pMap.get(key);
    }

}
