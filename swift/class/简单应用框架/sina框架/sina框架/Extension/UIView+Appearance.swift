//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension UIView{
    
    func setRoundAppearance( borderColor:UIColor, cornerRadius:CGFloat, backgroundColor:UIColor) {
        self.layer.backgroundColor=backgroundColor.CGColor
        self.layer.cornerRadius=cornerRadius
        self.layer.borderColor=borderColor.CGColor
        self.layer.borderWidth = 0.5
    }
    
    func setRoundAppearance( borderColor:UIColor, backgroundColor:UIColor) {
        self.setRoundAppearance(borderColor, cornerRadius: self.frame.size.height * 0.5, backgroundColor: backgroundColor)
    }
    
    func setRoundAppearance( borderColor:UIColor) {
        self.setRoundAppearance(borderColor, cornerRadius: self.frame.size.height * 0.5, backgroundColor: self.backgroundColor!)
    }
     
}
