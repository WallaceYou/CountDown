//
//  CountDownButton.m
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "CountDownButton.h"
#import "CountDownQueue.h"
#import "CountDownOperation.h"

@implementation CountDownButton

#pragma mark - overwrite
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [super addTarget:target action:action forControlEvents:controlEvents];
    [self refreshBlockCode];
}

- (void)dealloc {
    NSLog(@"%s dealloc",object_getClassName(self));
}

#pragma mark - Init
- (instancetype)initWithKeyInfo:(NSString *)keyInfo {
    if (self = [super init]) {
        self.queue = [CountDownQueue shareInstance];//所有的CountDownButton对象的queue属性都指向同一个全局队列
        self.keyInfo = keyInfo;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        NSAssert(NO, @"必须使用initWithKeyInfo方法初始化,%s", __func__);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSAssert(NO, @"必须使用initWithKeyInfo方法初始化,%s", __func__);
    }
    return self;
}



#pragma mark - 私有方法，不暴露给外部
- (void)refreshBlockCode {
    /* 查询看当前key的操作是否存在，如果存在说明此button正在倒计时，那么用代码重新点击一下Button，刷新一下回调 */
    [self searchOperationSuccess:^(CountDownOperation *operation) {
        if (operation.isExecuting) {
            [self setTitle:[NSString stringWithFormat:@"%.0lf秒后重发",operation.leftTime] forState:UIControlStateNormal];
        } else {
            [self setTitle:@"等待中.." forState:UIControlStateNormal];
        }
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } failed:nil];
}



@end
