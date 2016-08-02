//
//  String+Substring.swift
//  formoney
//
//  Created by 火星人 on 16/5/22.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension String {
    
    func substringToIndex(index: Int) -> String{
        return (self as NSString).substringToIndex(index) as String
    }
    
    func substringFromIndex(index: Int) -> String{
        return (self as NSString).substringFromIndex(index) as String
    }
    
    func substringWithRange(range: NSRange) -> String {
        return (self as NSString).substringWithRange(range) as String
    }
}
