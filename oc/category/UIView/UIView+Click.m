//
//  UIView+Click.m
//  UIView+Chick
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import "UIView+Click.h"
#import <objc/runtime.h>

@implementation UIView (Click)

static char touchKey;

-(void)actionTap:(UITapGestureRecognizer *) tap {
    OnTapBlock block = objc_getAssociatedObject(self, &touchKey);
    if (block) block(tap);
}


-(void)addTap:(OnTapBlock)block{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &touchKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
