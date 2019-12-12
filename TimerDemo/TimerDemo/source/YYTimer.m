//
//  YYTimer.m
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import "YYTimer.h"

@implementation YYTimer

static NSMutableDictionary *tasks;
static dispatch_semaphore_t sempahore;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks= [NSMutableDictionary dictionary];
        sempahore = dispatch_semaphore_create(1);
    });
}

+ (YYTimerTaskID)executeTaskWithStart:(NSTimeInterval)start
                             interval:(NSTimeInterval)interval
                             userInfo:(nullable id)userInfo
                              onQueue:(nullable dispatch_queue_t)queue
                              repeats:(BOOL)repeats
                                block:(void (^)(id userInfo))block {
    if (!block || start <0 || (interval <0 && repeats)) {
        return nil;
    }
    dispatch_queue_t targetQueue = queue ?: dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, targetQueue);
    
    dispatch_semaphore_wait(sempahore, DISPATCH_TIME_FOREVER);
    YYTimerTaskID taskID = [NSString stringWithFormat:@"%p",timer];
    [tasks setObject:timer forKey:taskID];
    dispatch_semaphore_signal(sempahore);
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        block(userInfo);
        if (!repeats) {
            [self cancelTimerWithID:taskID];
        }
    });
    dispatch_resume(timer);
    return taskID;
}



+ (YYTimerTaskID)executeTaskWithStart:(NSTimeInterval)start
                             interval:(NSTimeInterval)interval
                             userInfo:(nullable id)userInfo
                              onQueue:(nullable dispatch_queue_t)queue
                              repeats:(BOOL)repeats
                               target:(id)aTarget
                             selector:(SEL)aSelector
{
    return [self executeTaskWithStart:start interval:interval userInfo:userInfo onQueue:queue repeats:repeats block:^(id  _Nonnull userInfo) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([aTarget respondsToSelector:aSelector]) {
            [aTarget performSelector:aSelector withObject:userInfo];
        }
#pragma clang diagnostic pop
    }];
}

+ (void)cancelTimerWithID:(YYTimerTaskID)taskID {
    if (!taskID) {
        return;
    }
    dispatch_semaphore_wait(sempahore, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = tasks[taskID];
    [tasks removeObjectForKey:taskID];
    dispatch_semaphore_signal(sempahore);
    
    if (!timer) {
        return;
    }
    dispatch_source_cancel(timer);
}

@end
