package com.itheima.crm.workbench.service;

import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.pojo.ActivityRemark;
import com.itheima.crm.workbench.vo.PaginationVO;

import java.util.List;

public interface ActivityService {

    Boolean save(Activity a);

    PaginationVO pageList(ActivityRequestDTO aVo);

    Boolean delete(String[] ids);

    Activity getActivityById(String id);

    Boolean updateActivity(Activity a);

    Activity getDetail(String id);

    List<ActivityRemark> getRemarkByAid(String activityId);

    Boolean deleteRemarkByArid(String activityRemarkId);

    Boolean addActivityRemark(ActivityRemark ar);

    Boolean updateRemark(ActivityRemark ar);

    List<Activity> showActivityListByCid(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(String name, String clueId);

    List<Activity> getActivityListByName(String name);

}
