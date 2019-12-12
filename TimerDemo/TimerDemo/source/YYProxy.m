//
//  YYProxy.m
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import "YYProxy.h"

@implementation YYProxy

+ (instancetype)proxyWithTarget:(id)target {
    YYProxy *proxy = [YYProxy alloc];
    proxy->_target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_target];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}
@end
