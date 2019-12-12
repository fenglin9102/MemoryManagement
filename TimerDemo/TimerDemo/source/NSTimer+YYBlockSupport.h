//
//  NSTimer+YYBlockSupport.h
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (YYBlockSupport)

+ (NSTimer *)yy_timerWithTimeInterval:(NSTimeInterval)interval
                              repeats:(BOOL)repeats
                                block:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
