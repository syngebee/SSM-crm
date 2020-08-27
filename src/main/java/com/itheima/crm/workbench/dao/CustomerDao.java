package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.Customer;

public interface CustomerDao {
    Customer getCustomerByName(String companyName);

    int save(Customer customer);
}
