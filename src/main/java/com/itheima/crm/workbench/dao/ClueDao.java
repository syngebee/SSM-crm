package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.dto.ClueRequestDTO;
import com.itheima.crm.workbench.pojo.Clue;

import java.util.List;

public interface ClueDao {

    int save(Clue clue);

    Clue getDetailById(String id);

    Clue getClueById(String clueId);

    int delete(Clue clue);

    List<Clue> pageList(ClueRequestDTO cDto);

    int getSum(ClueRequestDTO cDto);
}
