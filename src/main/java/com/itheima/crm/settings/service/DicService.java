package com.itheima.crm.settings.service;


import com.itheima.crm.settings.pojo.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {
    Map<String,List<DicValue>> getAll();
}
