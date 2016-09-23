//
//  User.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class User: NSObject {
    
    static let sharedInstance = User()
    
    
    var birthday:String = ""
    var userId:String = "0"
    var sex:String = ""
    var mobile:String = ""
    var userName:String = ""
    var email:String = ""
    var avatar:String = ""
    var idCard:String = ""
    var password:String = ""
    var totalMonay: String = "23"
    var coinNumber: String = "200"
    
    var thumbNumber = 100       // 点赞数
    var commentNumber = 22      // 评论数
    
    var token: String = "this_is_initial_token"
    
    override init() {
        super.init()
        // 获取本地数据
        let tmpUserInfo = Helper.valueForKeyFromUserDefaults("userInfo")
        self.mj_setKeyValues(tmpUserInfo)
    }
    
    
    func setValuesFromLocal(){
        User.sharedInstance.mj_setKeyValues(Helper.valueForKeyFromUserDefaults("userInfo") as? NSDictionary)
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
