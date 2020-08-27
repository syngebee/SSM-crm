package com.itheima.crm.web.handler;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object user = request.getSession().getAttribute("user");
        System.out.println("拦截器执行,user值为: "+user);
        if (user==null){
            response.sendRedirect("/static/index.html");
            return false;
        }
        return true;
    }
}
