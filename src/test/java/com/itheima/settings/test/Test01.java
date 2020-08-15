package com.itheima.settings.test;

import com.itheima.crm.utils.DateTimeUtil;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;


public class Test01 {

    @Test
    public void test01(){
        String s = "2018-11-27 21:50:05";
        String now = DateTimeUtil.getSysTime();
        System.out.println("Now:"+now);

        if(now.compareTo(s)>0) {
            System.out.println("已失效");
        }else {
            System.out.println("未失效");
        }

    }
}
