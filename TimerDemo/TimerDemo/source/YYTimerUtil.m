//
//  YYTimerUtil.m
//  NSTimer
//
//  Created by 张枫林 on 2019/11/9.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import "YYTimerUtil.h"

@interface YYTimerBlockTarget : NSObject

@property (nonatomic, assign, readonly) SEL selector;
@property (nonatomic, weak, readonly) id target;
@property (nonatomic, weak) NSTimer *timer;

-(instancetype)initWithTarget:(id)aTarget selector:(SEL)aSelector;

- (void)invoke:(NSTimer *)timer;

@end

@implementation YYTimerBlockTarget

- (instancetype)initWithTarget:(id)aTarget selector:(SEL)aSelector {
    self = [super init];
    if (self) {
        _target = aTarget;
        _selector = aSelector;
    }
    return self;
}

- (void)invoke:(NSTimer *)timer {
    NSLog(@"_target->%@",_target);
    if ([_target respondsToSelector:_selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
          [_target performSelector:_selector withObject:timer];
#pragma clang diagnostic pop
    } else {
        // 防止外部自己没有关闭定时器
        NSLog(@"[_timer invalidate]");
        [_timer invalidate];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

@implementation YYTimerUtil

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    YYTimerBlockTarget *timerBlock = [[YYTimerBlockTarget alloc] initWithTarget:aTarget selector:aSelector];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:timerBlock selector:@selector(invoke:) userInfo:userInfo repeats:yesOrNo];
    timerBlock.timer = timer;
    return timer;
}

@end
