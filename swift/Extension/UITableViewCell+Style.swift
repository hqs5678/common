//
//  UITabBarController_Extensions.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension UITableViewCell{
    
    public func setSelectedBackgroundColor(color: UIColor){
        
        let bgview = UIView(frame: CGRectMake(0, 0, 10, 10))
        bgview.backgroundColor = kSelectedRowBackgroundColor
        self.selectedBackgroundView = bgview
    }
}