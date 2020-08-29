package com.itheima.crm.workbench.service;

import com.itheima.crm.workbench.pojo.Tran;
import com.itheima.crm.workbench.pojo.TranHistory;

import java.util.List;

public interface TranService {
    Boolean save(Tran tran,String customerName);

    Tran getTranById(String id);

    List<TranHistory> getHistoryByTranId(String tranId);

    Boolean changeStage(Tran tran);
}
