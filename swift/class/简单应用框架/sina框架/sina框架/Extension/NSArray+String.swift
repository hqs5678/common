//
//  File.swift
//  formoney
//
//  Created by 火星人 on 16/5/9.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension NSArray {
    
    func toFString() -> String{
        
        if self.count  == 0 {
            return ""
        }
        let str = NSMutableString()
        for obj in self {
            str.appendString(obj as! String)
            str.appendString(",,,")
        }
        return str.substringToIndex(str.length - 3)
    }

}