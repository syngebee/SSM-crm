package com.itheima.crm.web.listener;


import com.itheima.crm.settings.pojo.DicValue;
import com.itheima.crm.settings.service.DicService;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;


public class SysInitListener implements ServletContextListener {

//    @Autowired
//    private DicService dicService;

    @Override
    //监听到上下文对象创建时执行
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("服务器开始处理数据字典");

        //获取spring容器中的对象,通过WebApplicationContextUtils
        DicService dicService = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext()).getBean(DicService.class);

        //event这个对象可以获取到监听的对象
        ServletContext application = event.getServletContext();

        //获取所有的数据字典数据 键值对类型,此时spring应已初始化完bean对象
        Map<String,List<DicValue>> map =dicService.getAll();

        //存入ApplicationContext域中
        map.forEach(application::setAttribute);
        System.out.println("服务器处理数据字典结束");

        //处理可能性关系
        //存放结果
        System.out.println("=============================");
        System.out.println("开始处理可能性配置文件");
        Map<String, String> pMap = new HashMap<>();

        //解析可能性配置文件
        ResourceBundle rb = ResourceBundle.getBundle("Stage2Possibility");

        //遍历存放可能性对应关系
        Enumeration<String> keys = rb.getKeys();
        while(keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = rb.getString(key);
            pMap.put(key,value);
        }

        //把pMap放入服务器缓存中
        application.setAttribute("pMap",pMap);
        System.out.println("服务器配置文件处理结束");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("上下文对象销毁");
    }
}
