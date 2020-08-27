package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.pojo.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityDao {

    int save(Activity a);

    List<Activity> pageList(ActivityRequestDTO aVo);

    int getSum(ActivityRequestDTO aDto);

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    Activity getActivityById(String id);

    int updateActivity(Activity a);

    Activity getDetail(String id);

    List<Activity> showActivityListByCid(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(@Param("name") String name, @Param("clueId") String clueId);

    List<Activity> getActivityListByName(String name);
}
