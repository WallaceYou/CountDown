//
//  CountDownQueue.m
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "CountDownQueue.h"

static CountDownQueue *globalQueue = nil;

@implementation CountDownQueue

+ (CountDownQueue *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalQueue = [CountDownQueue new];
        globalQueue.maxConcurrentOperationCount = 3;//最多允许3条线程
    });
    return globalQueue;
}

@end
