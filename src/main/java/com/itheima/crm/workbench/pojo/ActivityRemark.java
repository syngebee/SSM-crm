package com.itheima.crm.workbench.pojo;

public class ActivityRemark {
    private String id;              //主键编号
    private String noteConten;      //备注信息
    private String createTime;      //创建时间
    private String createBy;        //创建人
    private String editTime;        //修改时间
    private String editBy;          //修改人
    private String editFlag;        //是否修改过
    private String activityId;      //活动id

    @Override
    public String toString() {
        return "ActivityRemark{" +
                "id='" + id + '\'' +
                ", noteConten='" + noteConten + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                ", editFlag='" + editFlag + '\'' +
                ", activityId='" + activityId + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNoteConten() {
        return noteConten;
    }

    public void setNoteConten(String noteConten) {
        this.noteConten = noteConten;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }
}
