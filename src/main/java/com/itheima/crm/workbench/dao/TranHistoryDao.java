package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.TranHistory;

import java.util.List;

public interface TranHistoryDao {
    int save(TranHistory tranHistory);

    List<TranHistory> getHistoryListByTranId(String tranId);
}
