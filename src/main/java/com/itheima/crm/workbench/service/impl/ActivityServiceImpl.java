package com.itheima.crm.workbench.service.impl;

import com.itheima.crm.settings.dao.UserDao;
import com.itheima.crm.workbench.dao.ActivityDao;
import com.itheima.crm.workbench.dao.ActivityRemarkDao;
import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.service.ActivityService;
import com.itheima.crm.workbench.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private ActivityDao activityDao;
    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Override
    public Boolean save(Activity a) {
        Boolean flag = true;

        int count =activityDao.save(a);
        if (count!=1){
            flag=false;
        }
        return flag;
    }

    @Override
    public PaginationVO pageList(ActivityRequestDTO aDto) {
        //service目的相当明确, 将dao层查询出来的数据,封装为PaginationVO Dao层只查数据出来,
        //目标:   int total;
        //        List<T> dataList;

        //初始化返回值
        PaginationVO<Activity> pv = new PaginationVO<>();
        //赋值1
        List<Activity> activities = activityDao.pageList(aDto);
        pv.setDataList(activities);
        //赋值2
        int sum = activityDao.getSum(aDto);
        pv.setTotal(sum);

        return pv;
    }

    @Override
    public Boolean delete(String[] ids) {
        //选择删除了一项/多项
        //有remark/没remark

        Boolean flag=true;

        int count1 = activityRemarkDao.getCountByAids(ids);
        System.out.println("count1 = " + count1);
        int count2 = activityRemarkDao.deleteByAids(ids);
        System.out.println("count2 = " + count2);
        if (count1!=count2){
            flag=false;
        }

        int count3 = activityDao.getCountByAids(ids);
        System.out.println("count3 = " + count3);
        int count4 = activityDao.deleteByAids(ids);
        System.out.println("count4 = " + count4);

        if (count3!=count4){
            flag=false;
        }
        return flag;
    }

    @Override
    public Activity getActivityById(String id) {
        Activity act = activityDao.getActivityById(id);
        if (act==null) System.out.println("修改查找活动没找到,id:"+id);
        return act;
    }

    @Override
    public Boolean updateActivity(Activity a) {
        Boolean flag = true;
        int count =activityDao.updateActivity(a);
        if (count!=1) flag=false;
        return flag;
    }


}
