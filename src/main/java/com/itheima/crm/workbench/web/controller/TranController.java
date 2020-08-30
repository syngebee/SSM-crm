package com.itheima.crm.workbench.web.controller;

import com.itheima.crm.settings.pojo.User;
import com.itheima.crm.settings.service.UserService;
import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.dto.TransactionRequestDTO;
import com.itheima.crm.workbench.pojo.Tran;
import com.itheima.crm.workbench.pojo.TranHistory;
import com.itheima.crm.workbench.service.CustomerService;
import com.itheima.crm.workbench.service.TranService;
import com.itheima.crm.workbench.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Tran")
public class TranController {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private TranService tranService;


    @RequestMapping("/addPage")
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

    @RequestMapping("/save")
    public String save(Tran tran,String customerName,HttpSession session){
        tran.setId(UUIDUtil.getUUID());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        tran.setCreateBy(((User)session.getAttribute("user")).getName());


        Boolean flag = tranService.save(tran,customerName);
        if (!flag){
            session.setAttribute("tranSaveMsg","failed");
        }
        return "redirect:/static/workbench/transaction/index.jsp";
    }

    @RequestMapping("/detail")
    public ModelAndView detail(String id,HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        Tran tran =tranService.getTranById(id);

        String stage = tran.getStage();
        Map<String,String> pMap = (Map<String,String>) request.getServletContext().getAttribute("pMap");
        String p = pMap.get(stage);

        tran.setPossibility(p);
        mv.addObject("tran",tran);
        mv.setViewName("/static/workbench/transaction/detail.jsp");
        return mv;
    }

    @RequestMapping("/getHistoryListByTranId")
    @ResponseBody
    public List<TranHistory> getHistoryListByTranId(String tranId,HttpServletRequest request){
        List<TranHistory> tranHistoryList = tranService.getHistoryByTranId(tranId);
        ServletContext servletContext = request.getServletContext();
        Map<String,String> pMap = (Map<String, String>) servletContext.getAttribute("pMap");
        for (TranHistory tranHistory : tranHistoryList) {
            String stage = tranHistory.getStage();
            String s = pMap.get(stage);
            tranHistory.setPossibility(s);
        }
        return tranHistoryList;
    }

    @RequestMapping("/changeStage")
    @ResponseBody
    public Map<String,Object> changeStage(Tran tran,HttpServletRequest request,HttpSession session){
        User user = (User) session.getAttribute("user");

        //tran负责两个事情,携带更新stage的数据 以及 新建交易历史需要的数据
        tran.setEditTime(DateTimeUtil.getSysTime());
        tran.setEditBy(user.getName());

        Boolean flag = tranService.changeStage(tran);

        //前台还需要刷新可能性,重新拿一下
        String stage = tran.getStage();
        Map<String,String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String possibility = pMap.get(stage);
        tran.setPossibility(possibility);

        //打个包给前端
        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("tran",tran);
        return map;
    }

    @RequestMapping("/getCharts")
    @ResponseBody
    public PaginationVO getCharts(){
        return tranService.getCharts();
    }


    @RequestMapping("/pageList")
    @ResponseBody
    public PaginationVO pageList(TransactionRequestDTO tDto){
        int skipCount = (tDto.getPageNo() - 1) * tDto.getPageSize();
        tDto.setSkipCount(skipCount);
        System.out.println(tDto);
        return tranService.pageList(tDto);
    }
}
