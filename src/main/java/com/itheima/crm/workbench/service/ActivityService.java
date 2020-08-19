package com.itheima.crm.workbench.service;

import com.itheima.crm.workbench.pojo.Activity;
import com.itheima.crm.workbench.dto.ActivityRequestDTO;
import com.itheima.crm.workbench.vo.PaginationVO;

import java.util.Map;

public interface ActivityService {

    Boolean save(Activity a);

    PaginationVO pageList(ActivityRequestDTO aVo);

    Boolean delete(String[] ids);

    Activity getActivityById(String id);

    Boolean updateActivity(Activity a);
}
