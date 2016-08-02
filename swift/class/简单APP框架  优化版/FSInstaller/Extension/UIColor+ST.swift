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
        let hue: CGFloat = (CGFloat(random() % 256) / 256.0 );  //  0.0 to 1.0
        let saturation: CGFloat = (CGFloat(random() % 128) / 256.0) + 0.5;  //  0.5 to 1.0, away from white
        let brightness: CGFloat = (CGFloat(random() % 128) / 256.0) + 0.2;  //  0.5 to 1.0, away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    public class func RGBA(r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    public class func RGB(r:Int, g:Int, b:Int) -> UIColor {
        return RGBA(r, g: g, b: b, a: 1)
    }
}
