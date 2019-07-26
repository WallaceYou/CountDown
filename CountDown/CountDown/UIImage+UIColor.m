//
//  UIImage+UIColor.m
//  CEAir
//
//  Created by yuyou on 16/6/22.
//  Copyright © 2016年 yuyou. All rights reserved.
//

#import "UIImage+UIColor.h"

@implementation UIImage (UIColor)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}
@end
