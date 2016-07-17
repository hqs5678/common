//
//  ThreadHelper.m
//  NAP
//
//  Created by hqs on 16/3/3.
//  Copyright © 2016年 AINIA. All rights reserved.
//

#import "ThreadHelper.h"

@implementation ThreadHelper

+ (void)doInBackground:(ThreadTask)task{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), task);
}

+ (void)doInBackgroundWithDelay:(NSTimeInterval)delay task:(ThreadTask)task{
    [ThreadHelper doInBackground:^{
        [NSThread sleepForTimeInterval:delay];
        task();
    }];
}

+ (void)doInBackground:(ThreadTask)task1 complete:(ThreadTask)task2{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^(){
        task1();
        task2();
    });
}

+ (void)doInMainThread:(ThreadTask)task{
    dispatch_async(dispatch_get_main_queue(), task);
}

+ (void)doInMainThreadWithDelay:(NSTimeInterval)delay task:(ThreadTask)task{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:delay];
        task();
    });
}

+ (void)doInMainThread:(ThreadTask)task1 complete:(ThreadTask)task2{
    dispatch_async(dispatch_get_main_queue(), ^{
        task1();
        task2();
    });
}

 
@end
