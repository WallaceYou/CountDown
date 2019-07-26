//
//  CountDownLabel.m
//  CountDown
//
//  Created by yuyou on 2018/6/28.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "CountDownLabel.h"
#import "CountDownOperation.h"
#import "CountDownQueue.h"


@implementation CountDownLabel

#pragma mark - overwrite
- (void)dealloc {
    NSLog(@"%s dealloc",object_getClassName(self));
}

#pragma mark - Init
- (instancetype)initWithKeyInfo:(NSString *)keyInfo {
    if (self = [super init]) {
        self.queue = [CountDownQueue shareInstance];//所有的CountDownButton对象的queue属性都指向同一个全局队列
        self.keyInfo = keyInfo;
        [self refreshBlockCode];
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
    [self searchOperationSuccess:^(CountDownOperation *operation) {
        if (operation.isExecuting) {
            self.text = operation.leftTimeStr;
        } else {
            self.text = @"等待中..";
        }
    } failed:nil];
}

@end
