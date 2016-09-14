//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension UIView{
    
    func setRoundAppearance( borderColor:UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius=self.frame.size.width * 0.5
        self.layer.borderColor=borderColor.CGColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setRoundAppearance( borderColor:UIColor, cornerRadius:CGFloat, backgroundColor:UIColor) {
        self.layer.backgroundColor=backgroundColor.CGColor
        self.layer.cornerRadius=cornerRadius
        self.layer.borderColor=borderColor.CGColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
    }
    
    func setRoundAppearance( borderColor:UIColor, cornerRadius:CGFloat) {
        
        self.layer.cornerRadius=cornerRadius
        self.layer.borderColor=borderColor.CGColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
    }
     
    func setRoundAppearance( borderColor:UIColor, backgroundColor:UIColor) {
        self.setRoundAppearance(borderColor, cornerRadius: self.frame.size.height * 0.5, backgroundColor: backgroundColor)
    }
    
    func setRoundAppearance( borderColor:UIColor) {
        self.setRoundAppearance(borderColor, cornerRadius: self.frame.size.height * 0.5, backgroundColor: self.backgroundColor!)
    }
    
    func setRoundAppearance() {
        setRoundAppearance(UIColor.blueColor(), borderWidth: 0)
    }
    
    public var cornerRadius: CGFloat {
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    public func setCornerRadius(corners: UIRectCorner, cornerRadii: CGSize){
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        shapLayer.path = maskPath.CGPath
        
        self.layer.mask = shapLayer
    }
    
    
     
}
