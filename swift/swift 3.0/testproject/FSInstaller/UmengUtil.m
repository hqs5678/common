//
//  UmengUtil.m
//  FSInstaller
//
//  Created by Apple on 2016/11/14.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

#import "UmengUtil.h"

@implementation UmengUtil

+ (NSString *)getDeviceId{
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
