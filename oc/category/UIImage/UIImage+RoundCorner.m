//
//  NSObject+RoundCorner.m
//  DrawImge
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "UIImage+RoundCorner.h"

@implementation UIImage (RoundCorner)

- (UIImage *)cornerRadius:(float)cornerRadius
{
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    
    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius] addClip];
    [self drawInRect:frame];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
