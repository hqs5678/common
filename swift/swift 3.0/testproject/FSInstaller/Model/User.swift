//
//  User.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class User: NSObject {
    
    static let shared: User = {
        return User()
    }()
    
    lazy var address = ""
    lazy var birthDate = ""
    lazy var dailyCapacity = ""
    lazy var depart = ""
    lazy var email = ""
    lazy var empno = ""
    lazy var gender = ""
    lazy var hireDate = ""
    lazy var idNumber = ""
    lazy var jobCity = ""
    lazy var jobNature = ""
    lazy var jobStatus = ""
    lazy var latitude = ""
    lazy var longitude = ""
    lazy var locaDesc = ""
    lazy var openIdWx = ""
    lazy var phone = ""
    lazy var realName = ""
    lazy var remark = ""
    lazy var status = ""
    lazy var uid = "this_is_initial_user_id"
    lazy var userName = ""
    
    lazy var avatar:String = ""
    
    lazy var thumbNumber = 100       // 点赞数
    lazy var commentNumber = 22      // 评论数
    
    lazy var token = "this_is_initial_token"
    
    override init() {
        super.init()
        // 获取本地数据
        let tmpUserInfo = Helper.valueForKeyFromUserDefaults("userInfo")
        self.mj_setKeyValues(tmpUserInfo)
    }
    
    
    func setValuesFromLocal(){
        User.shared.mj_setKeyValues(Helper.valueForKeyFromUserDefaults("userInfo") as? NSDictionary)
    }
    
    func removeValuesFromLocal(){
        Helper.saveToUserDefaults(nil, key: "userInfo")
    }
    
    // 保存到本地
    func saveToLocal(){
        let dict = self.mj_JSONObject()
        Helper.saveToUserDefaults(dict as AnyObject?, key: "userInfo")
    } 
    
}
