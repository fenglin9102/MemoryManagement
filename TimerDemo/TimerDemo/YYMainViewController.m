//
//  YYMainViewController.m
//  TimerDemo
//
//  Created by 张枫林 on 2019/12/12.
//  Copyright © 2019 张枫林. All rights reserved.
//

#import "YYMainViewController.h"
#import "NSTimer+YYBlockSupport.h"
#import "YYTimerUtil.h"
#import "YYProxy.h"
#import "YYTimer.h"


@interface YYMainViewController ()

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)YYTimerTaskID taskId;
@end

@implementation YYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}

- (void)test1 {
    // 内存泄露
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doTask:) userInfo:@"123456" repeats:YES];
}

- (void)test2 {
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer yy_timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",strongSelf.timer);
    }];
}

- (void)test3 {
    _timer = [YYTimerUtil scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTask:) userInfo:@"hello" repeats:YES];
}

- (void)test4 {
    _timer = [NSTimer timerWithTimeInterval:1 target:[YYProxy proxyWithTarget:self] selector:@selector(doTask:) userInfo:@"world" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)test5 {
    
    _taskId = [YYTimer executeTaskWithStart:1 interval:1 userInfo:@"dadadad" onQueue:nil repeats:YES block:^(id  _Nonnull userInfo) {
        NSLog(@"%@",userInfo);
    }];
    
    
}

- (void)doTask:(NSTimer *)timer {
    NSLog(@"%@",timer.userInfo);
}

- (void)dealloc {
    [_timer invalidate];
    [YYTimer cancelTimerWithID:_taskId];
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YYTimer cancelTimerWithID:_taskId];
}
@end
