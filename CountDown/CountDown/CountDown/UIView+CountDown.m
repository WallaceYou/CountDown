//
//  UIView+CountDown.m
//  CountDown
//
//  Created by yuyou on 2018/6/29.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "UIView+CountDown.h"
#import <objc/runtime.h>
#import "CountDownOperation.h"
#import "CountDownQueue.h"

@implementation UIView (CountDown)

#pragma mark - Init
- (instancetype)initWithKeyInfo:(NSString *)keyInfo {
    return [self init];
}

#pragma mark - Setter Getter
- (void)setKeyInfo:(NSString *)keyInfo {
    objc_setAssociatedObject(self, _cmd, keyInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)keyInfo {
    return objc_getAssociatedObject(self, @selector(setKeyInfo:));
}

- (void)setQueue:(NSOperationQueue *)queue {
    objc_setAssociatedObject(self, _cmd, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)queue {
    return objc_getAssociatedObject(self, @selector(setQueue:));
}

#pragma mark - Public Func
- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime countDowning:(countDowningBlock)countDowning countDownFinished:(countDownFinishedBlock)countDownFinished waitingBlock:(void (^)(void))waitingBlock {
    /* 查询看当前key的操作是否存在 */
    [self searchOperationSuccess:^(CountDownOperation *operation) {
        NSLog(@"找到啦");
        operation.countDowning = ^(NSTimeInterval timeInterval) {
            [self getDayHourMinuteSecondWithTime:timeInterval timeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
                countDowning(day, hour, minute, second);
            }];
        };
        
        operation.countDownFinished = countDownFinished;
    } failed:^(CountDownOperation *operation) {
        NSLog(@"没找到");
        
        //新建操作并加入到队列中
        operation = [CountDownOperation new];
        operation.countDowning = ^(NSTimeInterval timeInterval) {
            [self getDayHourMinuteSecondWithTime:timeInterval timeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
                countDowning(day, hour, minute, second);
            }];
        };
        operation.countDownFinished = countDownFinished;
        operation.leftTime = totalTime;
        operation.name = self.keyInfo;
        [self.queue addOperation:operation];
        
        //加入之后，判断队列是不是已经满了，如果已经满了，则回调waitingBlock
        if (self.queue.operationCount > self.queue.maxConcurrentOperationCount) {
            waitingBlock();
        }
    }];
}

- (void)searchOperationSuccess:(void(^)(CountDownOperation *operation))successBlock failed:(void(^)(CountDownOperation *operation))failedBlock {
    
    CountDownOperation *operation = nil;
    
    /* 查询看当前key的操作是否存在 */
    for (CountDownOperation *searchOperation in self.queue.operations) {
        if ([searchOperation.name isEqualToString:self.keyInfo]) {
            operation = searchOperation;
            break;
        }
    }
    
    if (operation) {//找到了
        if (successBlock) {
            successBlock(operation);
        }
        
    } else {
        if (failedBlock) {
            failedBlock(nil);
        }
    }
}


- (NSInteger)queueOperationCount {
    return self.queue.operations.count;
}


#pragma mark - 私有方法，不暴露给外部

- (void)getDayHourMinuteSecondWithTime:(NSTimeInterval)time timeBlock:(void(^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))timeBlock {
    int days = (int)(time/(3600*24));
    int hours = (int)((time-days*24*3600)/3600);
    int minute = (int)(time-days*24*3600-hours*3600)/60;
    int second = time-days*24*3600-hours*3600-minute*60;
    timeBlock(days, hours, minute, second);
}

@end
