package com.itheima.crm.settings.service.impl;

import com.itheima.crm.settings.dao.DicTypeDao;
import com.itheima.crm.settings.dao.DicValueDao;
import com.itheima.crm.settings.pojo.DicType;
import com.itheima.crm.settings.pojo.DicValue;
import com.itheima.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DicServiceImpl implements DicService {

    @Autowired
    private DicTypeDao dicTypeDao;
    @Autowired
    private DicValueDao dicValueDao;


    @Override
    public Map<String, List<DicValue>> getAll() {
        Map<String, List<DicValue>> map = new HashMap<>();
        //查出所有的type
        List<DicType> typeList = dicTypeDao.getAllTypes();
        //根据type查出所有对应的list
        for (DicType dicType : typeList) {
            String code = dicType.getCode();
            List<DicValue> valuesByType = dicValueDao.getValuesByType(code);
            map.put(code+"List",valuesByType);
        }
        return map;
    }
}
