//
//  UserHelper.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//


class UserHelper: NSObject {
    class func isLogined() -> Bool{
        return User.shared.token != "this_is_initial_token"
    }
    
    class func logout(){
        User.shared.token = "this_is_initial_token"
        User.shared.saveToLocal()
        User.shared.removeValuesFromLocal()
    }
    
}
