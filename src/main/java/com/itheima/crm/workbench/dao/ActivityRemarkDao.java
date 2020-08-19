package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ActivityRemark> getRemarkByAid(String activityId);

    int deleteRemarkByArid(String activityRemarkId);

    int addActivityRemark(ActivityRemark ar);

    int updateRemark(ActivityRemark ar);
}
