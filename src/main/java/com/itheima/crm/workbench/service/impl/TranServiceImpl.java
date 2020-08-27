package com.itheima.crm.workbench.service.impl;

import com.itheima.crm.workbench.dao.TranDao;
import com.itheima.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TranServiceImpl implements TranService {
    @Autowired
    private TranDao tranDao;
}
