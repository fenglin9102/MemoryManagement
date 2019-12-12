//
//  YYProxy.h
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYProxy : NSProxy

@property(nonatomic, readonly, weak)id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
