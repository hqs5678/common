//
//  UIView+Click.h
//  UIView+Chick
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Click)

typedef void (^OnTapBlock)(UITapGestureRecognizer *tapGestureRecognizer);


-(void)addTap:(OnTapBlock)block;

@end
