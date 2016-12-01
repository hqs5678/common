//
//  NSObject+Property.swift
//  testmyview
//
//  Created by Apple on 16/9/18.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

extension UIView {
    
    public func copyPropertiesReferenceFromView(_ view: UIView){
        
        view.enumerateProperties { (propertyName, value) in
            self.setValue(view.value(forKey: propertyName), forKey: propertyName)
        }
    }
}
