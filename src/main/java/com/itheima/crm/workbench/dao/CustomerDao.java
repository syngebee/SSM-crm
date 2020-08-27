package com.itheima.crm.workbench.dao;

import com.itheima.crm.workbench.pojo.Customer;

import java.util.List;

public interface CustomerDao {
    Customer getCustomerByName(String companyName);

    int save(Customer customer);

    List<String> getCustomerName(String name);
}
