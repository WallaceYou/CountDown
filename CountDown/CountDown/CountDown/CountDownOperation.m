//
//  CountDownOperation.m
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 com.morpx. All rights reserved.
//

#import "CountDownOperation.h"


@implementation CountDownOperation



- (void)main {
    
    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    for (; _leftTime > 0; _leftTime --) {
        
        NSLog(@"当前剩余时间：%.0lf，当前线程：%@",_leftTime,[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_countDowning) {
                _countDowning(_leftTime);
            }
        });
        
        /* 睡眠一秒钟 */
        sleep(1);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_countDownFinished) {
            _countDownFinished(0);
        }
    });
    
    if (self.taskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.taskIdentifier];
        self.taskIdentifier = UIBackgroundTaskInvalid;
    }
    
}


- (NSString *)leftTimeStr {
    
    int days = (int)(_leftTime/(3600*24));
    int hours = (int)((_leftTime-days*24*3600)/3600);
    int minute = (int)(_leftTime-days*24*3600-hours*3600)/60;
    int second = _leftTime-days*24*3600-hours*3600-minute*60;
    if (days) {
        return [NSString stringWithFormat:@"剩余 %d天 %d小时 %d分 %0d秒",days, hours, minute, second];
    }
    return [NSString stringWithFormat:@"剩余 %d小时 %d分 %0d秒",hours, minute, second];
//    return [NSString stringWithFormat:@"%d天%d小时%d分%02d秒",days, hours, minute, second];
    
}


@end
