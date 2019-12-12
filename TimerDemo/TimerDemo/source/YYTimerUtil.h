//
//  YYTimerUtil.h
//  NSTimer
//
//  Created by 张枫林 on 2019/11/9.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTimerUtil : NSObject


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
