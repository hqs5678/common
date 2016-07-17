//
//  String+Json.swift
//  formoney
//
//  Created by 火星人 on 16/4/21.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

extension String {
    
    func toJsonObj() -> AnyObject? {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        return try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
    }
}