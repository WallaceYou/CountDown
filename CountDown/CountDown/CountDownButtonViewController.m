//
//  CountDownButtonViewController.m
//  CountDown
//
//  Created by yuyou on 2018/6/27.
//  Copyright © 2018年 com.morpx. All rights reserved.
//

#import "CountDownButtonViewController.h"
#import "CountDownButton.h"
#import "Masonry.h"
#import "UIImage+UIColor.h"


#define ButtonSizeWidth     200
#define ButtonSizeHeight    100
#define VerticalSpacing     20
#define HorizontalSpacing   10
#define VerticalCount       2

@interface CountDownButtonViewController ()

@end

@implementation CountDownButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSendVerifyCodeBtnsWithCount:8];
}

- (void)dealloc {
    NSLog(@"");
}


- (void)createSendVerifyCodeBtnsWithCount:(NSInteger)btnCount {
    
    //背景无需指定大小，自适应
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    
    UIView *lastView = nil;
    
    //一行最多显示VerticalCount个
    for (int i = 1; i<=btnCount; i++) {
        //先算出这个按钮应该在第几行
        NSInteger horizontalCount = (i-1)/VerticalCount;
        
        //创建按钮
        CountDownButton *sendVerifyCodeBtn = [[CountDownButton alloc] initWithKeyInfo:[NSString stringWithFormat:@"btn%d",i]];
        [sendVerifyCodeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        [sendVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendVerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sendVerifyCodeBtn];
        
        //约束
        [sendVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView == nil) {
                make.left.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(ButtonSizeWidth, ButtonSizeHeight));
            } else {
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(VerticalSpacing);
                make.size.mas_equalTo(lastView);
            }
            
            make.top.mas_equalTo(horizontalCount * (ButtonSizeHeight+HorizontalSpacing));
            
            if (i % VerticalCount == 0) {
                make.right.mas_equalTo(0);
            }
            
            //如果是最后一个按钮
            if (i == btnCount) {
                make.bottom.mas_equalTo(0);
                if (i < VerticalCount) {
                    make.right.mas_equalTo(0);
                }
            }
        }];
        
        if (i % VerticalCount == 0) {
            lastView = nil;
        } else {
            lastView = sendVerifyCodeBtn;
        }
    }
}


- (void)sendVerifyCodeBtnClick:(CountDownButton *)sendVerifyCodeBtn {
    
    [sendVerifyCodeBtn startCountDownWithTotalTime:60 countDowning:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        [sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",totoalSecond] forState:UIControlStateNormal];
    } countDownFinished:^(NSTimeInterval leftTime) {
        [sendVerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    } waitingBlock:^{
        [sendVerifyCodeBtn setTitle:@"等待中.." forState:UIControlStateNormal];
    }];
    
}


@end
