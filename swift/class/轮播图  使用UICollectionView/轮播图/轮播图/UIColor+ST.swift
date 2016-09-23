//
//  UIColor+ST.swift
//  SwiftDrawRect
//
//  Created by 沈兆良 on 16/3/8.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {

    public class func colorRandom() -> UIColor
    {
        return UIColor.brown
    }
    
    public class func RGBA(_ r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    public class func RGB(_ r:Int, g:Int, b:Int) -> UIColor {
        return RGBA(r, g: g, b: b, a: 1)
    }
}
