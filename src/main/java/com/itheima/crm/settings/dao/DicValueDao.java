package com.itheima.crm.settings.dao;

import com.itheima.crm.settings.pojo.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> getValuesByType(String code);
}
