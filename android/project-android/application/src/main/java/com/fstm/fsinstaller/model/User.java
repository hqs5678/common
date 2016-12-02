package com.fstm.fsinstaller.model;

import com.hqs.utils.SharedPreferenceUtil;

/**
 * Created by apple on 2016/10/27.
 */

public class User {

    public String jobNature;
    public String token;
    public String remark;
    public String realName;
    public String dailyCapacity;
    public String phone;
    public String userName;
    public String locaDesc;
    public String gender;
    public String birthDate;
    public String email;
    public String hireDate;
    public String teamId;
    public String empno;
    public String active;
    public String uid;
    public String openIdWx;
    public String idNumber;

    private User(){
        update();
    }

    private static User instance;

    public static User getInstance(){
        if (instance == null){
            instance = new User();
            instance.update();
        }
        return instance;
    }

    public void update(){
        token = SharedPreferenceUtil.get("token","this_default_token");
        realName = SharedPreferenceUtil.get("realName","");
        userName = SharedPreferenceUtil.get("userName","");
        uid = SharedPreferenceUtil.get("uid","");
        phone = SharedPreferenceUtil.get("phone","");
        email = SharedPreferenceUtil.get("email","");
    }

    public void reset(){
        token = "";
        realName = "";
        userName = "";
        uid = "";
        phone = "";
        email = "";
        SharedPreferenceUtil.set("token", "this_default_token");
        SharedPreferenceUtil.set("realName","");
        SharedPreferenceUtil.set("userName","");
        SharedPreferenceUtil.set("email","");
    }


}
