//
//  CountDownLabelViewController.m
//  CountDown
//
//  Created by yuyou on 2018/6/28.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "CountDownLabelViewController.h"
#import "CountDownLabel.h"
#import "Masonry.h"
#import "UIImage+UIColor.h"

@interface CountDownLabelViewController ()

@property (nonatomic, strong) CountDownLabel *countDownLabel1;

@property (nonatomic, strong) CountDownLabel *countDownLabel2;

@end

@implementation CountDownLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubViews];
    
    [self startCountDonwLabel1];
    [self startCountDonwLabel2];
}

- (void)dealloc {
    NSLog(@"%s dealloc",object_getClassName(self));
}


- (void)createSubViews {
    
    _countDownLabel1 = [[CountDownLabel alloc] initWithKeyInfo:@"label1"];
    _countDownLabel1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_countDownLabel1];
    [_countDownLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(300, 70));
    }];
    
    
    _countDownLabel2 = [[CountDownLabel alloc] initWithKeyInfo:@"label2"];
    _countDownLabel2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_countDownLabel2];
    [_countDownLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_countDownLabel1.mas_bottom).mas_equalTo(50);
        make.centerX.mas_equalTo(_countDownLabel1);
        make.size.mas_equalTo(CGSizeMake(300, 70));
    }];
    
    
}

- (void)startCountDonwLabel1 {
    [self.countDownLabel1 startCountDownWithTotalTime:1000000 countDowning:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        if (day) {
            self.countDownLabel1.text = [NSString stringWithFormat:@"剩余 %ld天 %ld小时 %ld分 %02ld秒",day, hour, minute, second];
        } else {
            self.countDownLabel1.text = [NSString stringWithFormat:@"剩余 %ld小时 %ld分 %02ld秒", hour, minute, second];
        }
        
    } countDownFinished:^(NSTimeInterval leftTime) {
        self.countDownLabel1.text = [NSString stringWithFormat:@"剩余0天 0小时 0分 00秒"];
    } waitingBlock:^{
        self.countDownLabel1.text = @"等待中...";
    }];
}


- (void)startCountDonwLabel2 {
    [self.countDownLabel2 startCountDownWithTotalTime:9999 countDowning:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day) {
            self.countDownLabel2.text = [NSString stringWithFormat:@"剩余 %ld天 %ld小时 %ld分 %02ld秒",day, hour, minute, second];
        } else {
            self.countDownLabel2.text = [NSString stringWithFormat:@"剩余 %ld小时 %ld分 %02ld秒", hour, minute, second];
        }
        
    } countDownFinished:^(NSTimeInterval leftTime) {
        self.countDownLabel2.text = [NSString stringWithFormat:@"剩余0天 0小时 0分 00秒"];
    } waitingBlock:^{
        self.countDownLabel2.text = @"等待中...";
    }];
}




@end
