//
//  CountDownQueue.h
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDownQueue : NSOperationQueue

+ (CountDownQueue *)shareInstance;

@end
