package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.pojo.Activity;

import java.util.List;

public interface ActivityDao {

    int save(Activity a);

    List<Activity> pageList(ActivityRequestDTO aVo);

    int getSum(ActivityRequestDTO aDto);

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);
}
