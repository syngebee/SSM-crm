package com.itheima.crm.workbench.service.impl;

import com.itheima.crm.workbench.dao.ActivityDao;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityDao activityDao;

    @Override
    public Boolean save(Activity a) {
        Boolean flag = true;

        int count =activityDao.save(a);
        if (count!=1){
            flag=false;
        }
        return flag;
    }
}
