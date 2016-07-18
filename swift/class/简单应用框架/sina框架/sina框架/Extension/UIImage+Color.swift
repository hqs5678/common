//
//  UIImage+Color.swift
//  testswift
//
//  Created by hqs on 16/3/29.
//  Copyright © 2016年 hqs. All rights reserved.
//




extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        
        let rect=CGRectMake(0.0, 0.0, 1.0, 1.0);
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return theImage;
    }
}