//
//  UIImage+Color.swift
//  testswift
//
//  Created by hqs on 16/3/29.
//  Copyright © 2016年 hqs. All rights reserved.
//




extension UIImage {
    
    class func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect=CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return theImage!;
    }
}
