//
//  YYTimer.h
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NSString* YYTimerTaskID;
NS_ASSUME_NONNULL_BEGIN
@interface YYTimer : NSObject

+ (YYTimerTaskID)executeTaskWithStart:(NSTimeInterval)start
                             interval:(NSTimeInterval)interval
                             userInfo:(nullable id)userInfo
                              onQueue:(nullable dispatch_queue_t)queue
                              repeats:(BOOL)repeats
                                block:(void (^)(id userInfo))block;

+ (YYTimerTaskID)executeTaskWithStart:(NSTimeInterval)start
                             interval:(NSTimeInterval)interval
                             userInfo:(nullable id)userInfo
                              onQueue:(nullable dispatch_queue_t)queue
                              repeats:(BOOL)repeats
                               target:(id)aTarget
                             selector:(SEL)aSelector;

+ (void)cancelTimerWithID:(YYTimerTaskID)taskID;

@end
NS_ASSUME_NONNULL_END

