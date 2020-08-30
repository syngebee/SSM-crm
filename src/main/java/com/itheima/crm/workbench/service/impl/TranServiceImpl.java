package com.itheima.crm.workbench.service.impl;

import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.dao.CustomerDao;
import com.itheima.crm.workbench.dao.TranDao;
import com.itheima.crm.workbench.dao.TranHistoryDao;
import com.itheima.crm.workbench.dto.TransactionRequestDTO;
import com.itheima.crm.workbench.pojo.Customer;
import com.itheima.crm.workbench.pojo.Tran;
import com.itheima.crm.workbench.pojo.TranHistory;
import com.itheima.crm.workbench.service.TranService;
import com.itheima.crm.workbench.vo.PaginationVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranDao tranDao;

    @Autowired
    private CustomerDao customerDao;

    @Autowired
    private TranHistoryDao tranHistoryDao;

    @Override
    public Boolean save(Tran tran,String customerName) {
        Boolean flag = true ;

        //查询客户名称
        Customer customer = customerDao.getCustomerByName(customerName);

        //如果客户没有的话,需要创建客户
        if (customer==null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(tran.getOwner());
            customer.setDescription(tran.getDescription());
            customer.setContactSummary(tran.getContactSummary());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setName(customerName);

            int count1 = customerDao.save(customer);
            if (count1!=1){
                flag=false;
            }
        }

        //拿到客户id
        tran.setCustomerId(customer.getId());

        //创建交易
        int count2 =tranDao.save(tran);
        if (count2!=1){
            flag=false;
        }

        //同时创建交易历史
        TranHistory tranHistory = new TranHistory();
        //拷贝属性,id同名忽略,还剩自己id和tranId
        BeanUtils.copyProperties(tran,tranHistory,"id","createTime");
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());

        //创建交易历史
        int count3 = tranHistoryDao.save(tranHistory);
        if (count3!=1){
            flag=false;
        }

        return flag;
    }

    @Override
    public Tran getTranById(String id) {
        return tranDao.getTranById(id);
    }

    @Override
    public List<TranHistory> getHistoryByTranId(String tranId) {
        return tranHistoryDao.getHistoryListByTranId(tranId);
    }

    @Override
    public Boolean changeStage(Tran tran) {

        //先更新stage
        boolean flag = true;
        int count1 = tranDao.changeStage(tran);
        if (count1!=1){
            flag=false;
        }

        //生成一条交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getEditBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());

        int count2 = tranHistoryDao.save(tranHistory);
        if (count2!=1){
            flag=false;
        }
        return flag;

    }

    @Override
    public PaginationVO getCharts() {
        PaginationVO<Map<String, String>> pv = new PaginationVO<>();

        int total =tranDao.getTotal();
        List<Map<String,String>> dataList =tranDao.getTranSumByStage();

        pv.setTotal(total);
        pv.setDataList(dataList);

        return pv;
    }

    @Override
    public PaginationVO pageList(TransactionRequestDTO tDto) {
        System.out.println(tDto);
        //初始化返回值
        PaginationVO<Tran> pv = new PaginationVO<>();
        //赋值1
        List<Tran> trans = tranDao.pageList(tDto);
        pv.setDataList(trans);
        //赋值2
        int sum = tranDao.getSum(tDto);
        pv.setTotal(sum);
        return pv;

    }
}
