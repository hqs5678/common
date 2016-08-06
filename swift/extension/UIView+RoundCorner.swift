//
//  UIView_RoundCorner_Extension.swift
//  testRoundImage
//
//  Created by 火星人 on 16/3/9.
//  Copyright © 2016年 火星人. All rights reserved.
//

import UIKit

extension UIView{
    
    func setRoundCorner(radius radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
   
    
}
