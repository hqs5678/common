//
//  User.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class User: NSObject {
    
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
    
    var token: String = "this_is_initial_token"
    
    class var sharedInstance:User{
        struct Instance {
            static var onceToken:dispatch_once_t = 0
            static var instance:User?
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            // 获取本地数据
            let tmpUserInfo = Helper.valueForKeyFromUserDefaults("userInfo")
            if tmpUserInfo == nil {
                Instance.instance = User()
            }
            else {
                let dict = tmpUserInfo as! NSDictionary
                Instance.instance = User.mj_objectWithKeyValues(dict)
            }
        })
        
        return Instance.instance!
    }
    
    func setValuesFromLocal(){
        User.sharedInstance.mj_setKeyValues(Helper.valueForKeyFromUserDefaults("userInfo") as? NSDictionary)
    }
    
    // 保存到本地
    func saveToLocal(){
        let dict = self.mj_JSONObject()
        Helper.saveToUserDefaults(dict, key: "userInfo")
    } 
    
}
