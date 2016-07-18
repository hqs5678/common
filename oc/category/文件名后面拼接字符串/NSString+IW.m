//
//  UIImage+IWe.m
//  ItcastWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+IW.h"

@implementation NSString (File)
// 在文件名后拼接一段字符串（扩展名不变）
- (NSString *)fileNameAppendString:(NSString *)str
{
    // 如果没有传入任何字符串
    if (str.length == 0) return self;
    
    // 1.文件拓展名
    NSString *extension = [self pathExtension];
    // 2.获得没有拓展名的文件名
    NSString *shortName = [self stringByDeletingPathExtension];
    // 3.拼接str
    NSString *dest = [shortName stringByAppendingString:str];
    // 4.拼接拓展名
    if (extension.length) {
        return [dest stringByAppendingPathExtension:extension];
    } else {
        return dest;
    }
}
@end
