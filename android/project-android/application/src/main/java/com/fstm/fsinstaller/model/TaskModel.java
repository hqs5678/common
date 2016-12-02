package com.fstm.fsinstaller.model;

import org.xutils.db.annotation.Column;
import org.xutils.db.annotation.Table;

import java.util.ArrayList;

/**
 * Created by apple on 2016/10/26.
 *
 * 使用 xUtils 保存到数据库
 */



@Table(name = "tb_task")
public class TaskModel {

    @Column(name = "id", isId = true)
    private Integer id;

    @Column(name = "propertyAddr")
    public String propertyAddr;

    @Column(name = "linkMan")
    public String linkMan;

    @Column(name = "workSheetStatus")
    public String workSheetStatus;

    @Column(name = "period")
    public String period;

    @Column(name = "dealType")
    public String dealType;

    @Column(name = "reservationServiceTime")
    public String reservationServiceTime;

    @Column(name = "changeServiceDate")
    public String changeServiceDate;

    @Column(name = "uid")
    public String uid;

    @Column(name = "changeServicePeriod")
    public String changeServicePeriod;

    @Column(name = "linkPhone")
    public String linkPhone;

    @Column(name = "visitOrderNo")
    public String visitOrderNo;

    @Column(name = "product")
    public String product;


    @Column(name = "distributeTime")
    public String distributeTime;

    @Column(name = "houseno")
    public String houseno;

    @Column(name = "quesDesc")
    public String quesDesc;

    @Column(name = "category")
    public String category;

    @Column(name = "roomno")
    public String roomno;

    @Column(name = "record")
    public String record;

    public ArrayList<TaskRecord> records;


    public TaskModel(){}





    public String getPropertyAddr() {
        return propertyAddr;
    }

    public void setPropertyAddr(String propertyAddr) {
        this.propertyAddr = propertyAddr;
    }

    public String getLinkMan() {
        return linkMan;
    }

    public void setLinkMan(String linkMan) {
        this.linkMan = linkMan;
    }

    public String getWorkSheetStatus() {
        return workSheetStatus;
    }

    public void setWorkSheetStatus(String workSheetStatus) {
        this.workSheetStatus = workSheetStatus;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getDealType() {
        return dealType;
    }

    public void setDealType(String dealType) {
        this.dealType = dealType;
    }

    public String getReservationServiceTime() {
        return reservationServiceTime;
    }

    public void setReservationServiceTime(String reservationServiceTime) {
        this.reservationServiceTime = reservationServiceTime;
    }

    public String getChangeServiceDate() {
        return changeServiceDate;
    }

    public void setChangeServiceDate(String changeServiceDate) {
        this.changeServiceDate = changeServiceDate;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getChangeServicePeriod() {
        return changeServicePeriod;
    }

    public void setChangeServicePeriod(String changeServicePeriod) {
        this.changeServicePeriod = changeServicePeriod;
    }

    public String getLinkPhone() {
        return linkPhone;
    }

    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone;
    }

    public String getVisitOrderNo() {
        return visitOrderNo;
    }

    public void setVisitOrderNo(String visitOrderNo) {
        this.visitOrderNo = visitOrderNo;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getDistributeTime() {
        return distributeTime;
    }

    public void setDistributeTime(String distributeTime) {
        this.distributeTime = distributeTime;
    }

    public String getHouseno() {
        return houseno;
    }

    public void setHouseno(String houseno) {
        this.houseno = houseno;
    }

    public String getQuesDesc() {
        return quesDesc;
    }

    public void setQuesDesc(String quesDesc) {
        this.quesDesc = quesDesc;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getRoomno() {
        return roomno;
    }

    public void setRoomno(String roomno) {
        this.roomno = roomno;
    }

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }


    //    "linkMan": "王佳",
//            "distributeTime": "",
//            "workSheetStatus": "已派单",
//            "houseno": "",
//            "reservationServiceTime": "2016-09-27 13:00",
//            "quesDesc": "突然没有燃气了。已经联系燃气公司说没有因为维修和欠费而停气，让更换电池，可是灶具没有电池。",
//            "propertyAddr": "北京朝阳南湖中园二区217号楼3单元1层101",
//            "category": "电器",
//            "roomno": "",
//            "period": "",
//            "dealType": "",
//            "changeServiceDate": "",
//            "uid": "",
//            "changeServicePeriod": "",
//            "record": [],
//            "linkPhone": "15110290913",
//            "visitOrderNo": "WX20160925699999SM700323",
//            "product": "维修灶具"
//    "propertyAddr": "北京朝阳白家庄东里18号楼1单元5层503",
//            "linkMan": "李姝",
//            "workSheetStatus": "已上门",
//            "period": "上午9:00-13:00",
//            "dealType": "",
//            "reservationServiceTime": "2016-10-25 11:47",
//            "changeServiceDate": "",
//            "uid": "",
//            "changeServicePeriod": "",
//            "linkPhone": "18511171397",
//            "visitOrderNo": "WX20160804248309SM248310",
//            "product": "维修冰箱"
}
