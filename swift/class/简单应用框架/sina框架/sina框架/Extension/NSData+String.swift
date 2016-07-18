//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension NSData{
    
    
    func toString() -> String{
        let str = NSString(data: self, encoding: NSUTF8StringEncoding)
        return str as! String
    }
    
    
}
