package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {
    List<ClueRemark> getListById(String clueId);

    int delete(ClueRemark clueRemark);
}
