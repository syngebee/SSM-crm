package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.ClueActivityRelation;
import com.itheima.crm.workbench.pojo.ClueRemark;

import java.util.List;

public interface ClueActivityRelationDao {
    int unbundByClueActivityRelationId(String clueActivityRelationId);

    int bund(ClueActivityRelation clueActivityRelation);

    List<ClueActivityRelation> getListByClueId(String clueId);

    int delete(ClueActivityRelation clueActivityRelation);
}
