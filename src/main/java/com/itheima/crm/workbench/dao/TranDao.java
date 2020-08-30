package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.dto.TransactionRequestDTO;
import com.itheima.crm.workbench.pojo.Tran;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface TranDao {
    int save(Tran tran);

    Tran getTranById(String id);

    int changeStage(Tran tran);

    @Select("SELECT COUNT(*) FROM `tbl_tran`")
    int getTotal();

    @Select(" SELECT stage `name`,COUNT(*) `value` FROM `tbl_tran` GROUP BY stage")
    List<Map<String,String>> getTranSumByStage();

    List<Tran> pageList(TransactionRequestDTO tDto);

    int getSum(TransactionRequestDTO tDto);
}
