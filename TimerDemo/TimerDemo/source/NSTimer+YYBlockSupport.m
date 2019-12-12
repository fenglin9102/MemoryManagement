//
//  NSTimer+YYBlockSupport.m
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import "NSTimer+YYBlockSupport.h"

@implementation NSTimer (YYBlockSupport)

+ (NSTimer *)yy_timerWithTimeInterval:(NSTimeInterval)interval
                              repeats:(BOOL)repeats
                                block:(void (^)(NSTimer *timer))block {
    
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(yy_executeBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)yy_executeBlock:(NSTimer *)timer{
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
