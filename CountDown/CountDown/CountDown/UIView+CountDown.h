//
//  UIView+CountDown.h
//  CountDown
//
//  Created by yuyou on 2018/6/29.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountDownOperation,CountDownQueue;

typedef void(^countDowningBlock)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second);
typedef void(^countDownFinishedBlock)(NSTimeInterval leftTime);


//能显示倒计时的一定是View，不管是在Button上还是Label上显示倒计时，都是View，所以给View写分类
@interface UIView (CountDown)

/** 此View类中有一个全局operation队列，这个队列是单例的，其中存放着许多操作，并且每个操作都有自己的唯一标识Key，所有的倒计时View对象的queue属性都指向同一个全局队列（因为它是单例的） */
@property (nonatomic, strong) CountDownQueue *queue;


/** 这个keyInfo字段是唯一的，不能与其他倒计时View的keyInfo相同，它代表着为此倒计时的操作的唯一标识，退出界面重新进入时根据这个标识才能在队列里找这个操作 */
@property (nonatomic, copy) NSString *keyInfo;

/** 使用keyInfo初始化倒计时View */
- (instancetype)initWithKeyInfo:(NSString *)keyInfo;


/**
 开始倒计时
 
 @param totalTime           此次倒计时的总时长
 @param countDowning        正在倒计时时，每秒钟会回调一次，将当前秒数返回
 @param countDownFinished   倒计时完成后的回调，将当前秒数返回（永远为0，因为已经倒计时完了）
 @param waitingBlock        等待回调，如果队列已达到最大线程数，则会使此次倒计时操作进入就绪状态，此时回调的block
 */
- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime countDowning:(countDowningBlock)countDowning countDownFinished:(countDownFinishedBlock)countDownFinished waitingBlock:(void(^)(void))waitingBlock;

/** 查询队列中此View是否正在倒计时 */
- (void)searchOperationSuccess:(void(^)(CountDownOperation *operation))successBlock failed:(void(^)(CountDownOperation *operation))failedBlock;

/** 当前队列的线程数 */
- (NSInteger)queueOperationCount;

@end
