package com.fstm.fsinstaller.model;

/**
 * Created by apple on 2016/11/16.
 */

public class FeeListItemModel extends MenuListItemModel{

    public String repairFee;
    public String otherFee;
    public String id;
    public String discount;
    public String remark;
    public String repairProName;
    public String visitFee;
    public String partsFee;
    public String number = "1";
    public boolean checked = false;

    //{"repairFee":0.0,"otherFee":0.0,"id":1,"discount":50.0,"remark":"","repairProName":"上门机器正常或检测出故障后客户不让维修","visitFee":50.0,"partsFee":0.0}
}
