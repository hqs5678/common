//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension NSDictionary{
    
    func toJsonString() -> String{
        let data:NSData = try! NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions())
        
        return data.toString()
    }
    
}
