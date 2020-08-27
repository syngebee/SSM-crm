package com.itheima.crm.workbench.service;

import com.itheima.crm.workbench.pojo.Clue;
import com.itheima.crm.workbench.pojo.Tran;

public interface ClueService {
    Boolean save(Clue clue);

    Clue getDetailById(String id);

    Boolean unbundByClueActivityRelationId(String clueActivityRelationId);

    Boolean bund(String cid, String[] aid);

    Boolean convert(String clueId, Tran tran, Boolean tranflag, String createBy);
}
