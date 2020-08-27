package com.itheima.crm.workbench.service.impl;

import com.itheima.crm.utils.DateTimeUtil;
import com.itheima.crm.utils.UUIDUtil;
import com.itheima.crm.workbench.dao.*;
import com.itheima.crm.workbench.pojo.*;
import com.itheima.crm.workbench.service.ClueService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {
    //线索相关表
    @Autowired
    private ClueDao clueDao;
    @Autowired
    private ClueActivityRelationDao clueActivityRelationDao;
    @Autowired
    private ClueRemarkDao clueRemarkDao;

    //联系人相关表
    @Autowired
    private ContactsDao contactsDao;
    @Autowired
    private ContactsRemarkDao contactsRemarkDao;
    @Autowired
    private ContactActivityRelationDao contactActivityRelationDao;

    //客户相关表
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private CustomerRemarkDao customerRemarkDao;


    //交易相关表
    @Autowired
    private TranDao tranDao;
    @Autowired
    private TranHistoryDao tranHistoryDao;

    @Override
    public Boolean save(Clue clue) {
        Boolean flag = true;
        int count = clueDao.save(clue);
        if (count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public Clue getDetailById(String id) {
        return clueDao.getDetailById(id);
    }

    @Override
    public Boolean unbundByClueActivityRelationId(String clueActivityRelationId) {
        Boolean flag = true;
        int count = clueActivityRelationDao.unbundByClueActivityRelationId(clueActivityRelationId);
        if (count!=1){
            flag=false;
        }
        return flag;
    }

    @Override
    public Boolean bund(String cid, String[] aid) {
        Boolean flag = true;
        for (String s : aid) {
            ClueActivityRelation car = new ClueActivityRelation();
            car.setActivityId(s);
            car.setClueId(cid);
            car.setId(UUIDUtil.getUUID());
            int count = clueActivityRelationDao.bund(car);
            if(count!=1){
                flag=false;
            }
        }
        return flag;
    }

    @Override
    public Boolean convert(String clueId, Tran tran, Boolean tranflag, String createBy) {
        //时间留着备用
        String createTime = DateTimeUtil.getSysTime();
        //记录操作成功失败的标识
        Boolean flag = true;

        //先查线索的所有信息, 把线索和公司相关的信息添加到客户中,把个人相关的信息添加到联系人
        Clue clue =clueDao.getClueById(clueId);
        //(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
        String companyName = clue.getCompany();

        //查询是否有这个公司
        Customer customer = customerDao.getCustomerByName(companyName);
        //customer等于空就得新建
        if (customer==null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setAddress(clue.getAddress());
            customer.setCreateBy(createBy);
            customer.setCreateTime(createTime);
            customer.setOwner(clue.getOwner());
            customer.setName(companyName);
            customer.setPhone(clue.getPhone());
            customer.setWebsite(clue.getWebsite());
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());
            //添加客户
            int count1 =customerDao.save(customer);
            if (count1 !=1){
                flag=false;
            }
        }
        //第二步处理完后,客户就有了,可以通过customer.getId()拿到客户id

        //(3) 通过线索对象提取联系人信息，保存联系人
        Contacts contacts = new Contacts();

        //复制拷贝

        BeanUtils.copyProperties(clue,contacts,"id","createBy","createTime");
        contacts.setId(UUIDUtil.getUUID());
        contacts.setCustomerId(customer.getId());
        contacts.setCreateBy(createBy);
        contacts.setCreateTime(createTime);

        //留作备份(需求更改时参考)
/*        contacts.setId(UUIDUtil.getUUID());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullname(clue.getFullname());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(createBy);
        contacts.setCreateTime(createTime);
        contacts.setDescription(clue.getDescription());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());*/

        System.out.println(contacts);
        //添加联系人
        int count2 = contactsDao.save(contacts);
        if (count2!=1){
            flag=false;
        }
        //第三步处理完后,联系人就有了,可以通过contacts.getId()拿到联系人id

        //(4) 线索备注转换到客户备注以及联系人备注
        //查出与该线索关联的备注信息
        List<ClueRemark> clueRemarkList= clueRemarkDao.getListById(clueId);
        //联系人备注和客户备注添加信息
        for (ClueRemark clueRemark : clueRemarkList) {
            //备注,editFlag,clueId
            String noteContent = clueRemark.getNoteContent();

            //联系人备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            contactsRemark.setId(UUIDUtil.getUUID());
            //联系人备注添加
            int count3 = contactsRemarkDao.save(contactsRemark);
            if (count3!=1){
                flag=false;
            }

            //客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(createTime);
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);
            customerRemark.setId(UUIDUtil.getUUID());
            //客户备注添加
            int count4 = customerRemarkDao.save(customerRemark);
            if (count4!=1){
                flag=false;
            }
        }

        //(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getListByClueId(clueId);

        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
            String activityId = clueActivityRelation.getActivityId();

            //添加联系人活动关联关系
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(contacts.getId());
            //添加联系人活动关系
            int count5 = contactActivityRelationDao.save(contactsActivityRelation);
            if (count5!=1){
                flag=false;
            }
        }

        //(6) 如果有创建交易需求，创建一条交易
        if (tranflag){
            tran.setContactsId(contacts.getId());
            tran.setCustomerId(customer.getId());
            tran.setContactSummary(clue.getContactSummary());
            tran.setNextContactTime(clue.getNextContactTime());
            tran.setDescription(clue.getDescription());
            tran.setOwner(clue.getOwner());
            tran.setSource(clue.getSource());

            int count6 = tranDao.save(tran);
            if (count6!=1){
                flag=false;
            }
            //(7) 如果创建了交易，则创建一条该交易下的交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateBy(createBy);
            tranHistory.setCreateTime(createTime);
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());

            int count7 = tranHistoryDao.save(tranHistory);
            if (count7 != 1){
                flag=false;
            }
        }

        //(8) 删除线索备注
        //使用第四步时查询的线索备注列表,遍历删除,使用主键删走索引效率快
        //根据clueId删也行,用备注列表删可读性更强,走外键删
        //传list拼动态sql也可以,但是犯不着这么麻烦

        for (ClueRemark clueRemark : clueRemarkList) {
            int count8 =clueRemarkDao.delete(clueRemark);
            if (count8 != 1){
                flag=false;
            }
        }

        //(9) 删除线索和市场活动的关系
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
            int count9 = clueActivityRelationDao.delete(clueActivityRelation);
            if (count9 != 1){
                flag=false;
            }
        }

        //(10) 删除线索
        int count10 = clueDao.delete(clue);
        if (count10 !=1){
            flag=false;
        }

        return flag;
    }


}
