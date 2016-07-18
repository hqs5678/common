//
//  ThreadHelper.h
//  NAP
//
//  Created by hqs on 16/3/3.
//  Copyright © 2016年 AINIA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ThreadTask)(void);

@interface ThreadHelper : NSObject

// 在后台线程中执行任务
+ (void)doInBackground:(ThreadTask)task;
+ (void)doInBackgroundWithDelay:(NSTimeInterval)delay task:(ThreadTask)task;
+ (void)doInBackground:(ThreadTask)task1 complete:(ThreadTask)task2;

// 在主线程中执行任务
+ (void)doInMainThread:(ThreadTask)task;
+ (void)doInMainThreadWithDelay:(NSTimeInterval)delay task:(ThreadTask)task;
+ (void)doInMainThread:(ThreadTask)task1 complete:(ThreadTask)task2;



@end
