package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.Clue;

public interface ClueDao {

    int save(Clue clue);

    Clue getDetailById(String id);

    Clue getClueById(String clueId);

    int delete(Clue clue);
}
