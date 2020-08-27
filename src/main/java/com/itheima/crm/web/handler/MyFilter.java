package com.itheima.crm.web.handler;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyFilter implements Filter {
    private String[] ignoreArr = null;

    public void init(FilterConfig config) throws ServletException {
        ignoreArr = config.getInitParameter("ignore").split(",");
    }

    public void destroy() {
    }

    //自定义方法,校验请求是否是需要忽略
    private Boolean isIgnore(HttpServletRequest request){
        String uri = request.getRequestURI();
        for (String s : ignoreArr) {
            if (uri.contains(s)){
                return true;
            }
        }
        return false;
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest)req;
        HttpServletResponse response = (HttpServletResponse)resp;

        if (!isIgnore(request)){
            Object user = request.getSession().getAttribute("user");
            System.out.println("拦截器执行,user值为: "+user);
            if (user==null){
                response.sendRedirect("/static/index.html");
            }
        }
        chain.doFilter(req, resp);
    }



}
