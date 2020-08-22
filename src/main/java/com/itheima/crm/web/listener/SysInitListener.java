package com.itheima.crm.web.listener;


import com.itheima.crm.settings.pojo.DicValue;
import com.itheima.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;
import java.util.Map;


public class SysInitListener implements ServletContextListener {

//    @Autowired
//    private DicService dicService;

    @Override
    //监听到上下文对象创建时执行
    public void contextInitialized(ServletContextEvent event) {
        DicService dicService = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext()).getBean(DicService.class);
        //event这个对象可以获取到监听的对象
        ServletContext application = event.getServletContext();
        //获取所有的数据字典数据 键值对类型,此时spring应已初始化完bean对象
        System.out.println("dicService: "+ dicService);
        Map<String,List<DicValue>> map =dicService.getAll();
        //存入ApplicationContext域中
        map.forEach(application::setAttribute);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("上下文对象销毁前");
    }
}
