//
//  UIImage+Color.h
//  gmu
//
//  Created by edz on 2018/4/20.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+(UIImage *)newBoxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
