package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.Tran;

public interface TranDao {
    int save(Tran tran);

    Tran getTranById(String id);

    int changeStage(Tran tran);
}
