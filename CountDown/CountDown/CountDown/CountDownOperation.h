//
//  CountDownOperation.h
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountDownOperation : NSOperation


/** 正在倒计时时，每秒钟会回调一次，将当前秒数返回 */
@property (nonatomic, copy) void(^countDowning)(NSTimeInterval timeInterval);

/** 倒计时完成后的回到，将当前秒数返回（永远为0，因为已经倒计时完了） */
@property (nonatomic, copy) void(^countDownFinished)(NSTimeInterval timeInterval);

/** 后台任务标示,确保任务进入后台依然能够计时 */
@property (nonatomic, assign) UIBackgroundTaskIdentifier taskIdentifier;

/** 当前操作的剩余时间 */
@property (nonatomic, assign) NSTimeInterval leftTime;

/** 当前操作的剩余时间字符串 */
@property (nonatomic, copy) NSString *leftTimeStr;

@end
