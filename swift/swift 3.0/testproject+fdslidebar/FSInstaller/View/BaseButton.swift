//
//  BaseButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/19.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class BaseButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup(){
        
        self.backgroundColor = kButtonNormalColor
        self.cornerRadius = kCornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: kFontSizeNormal)
    }

}
