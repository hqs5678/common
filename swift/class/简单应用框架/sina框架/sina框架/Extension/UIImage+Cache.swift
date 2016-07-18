//
//  Extensions.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//




extension UIImage{
  
    
    func writeToFile(filePath:String){
        let data = UIImagePNGRepresentation(self)!
        data.writeToFile(filePath, atomically: false)
    }
}