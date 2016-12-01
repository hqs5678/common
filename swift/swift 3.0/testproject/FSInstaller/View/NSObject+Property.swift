//
//  NSObject+Property.swift
//  testmyview
//
//  Created by Apple on 16/9/18.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    fileprivate struct AssociatedKeys {
        static var cview1 = "cview1"
    }
    
    public func enumerateProperties(_ enumeration: ((_ propertyName: String, _ value: AnyObject?)->())){
        
        
        var outCount: UInt32 = 0;
        let properties: UnsafeMutablePointer<objc_property_t?> = class_copyPropertyList(self.classForCoder, &outCount)
        
        for i in 0 ..< outCount {
            let property = properties[Int(i)]
            
            let nameCString = property_getName(property)
            let name = String(validatingUTF8: nameCString!)!
            let value = objc_getAssociatedObject(self, &AssociatedKeys.cview1)
            
            enumeration(name, value as AnyObject?)
        }
    }
    
}
 
