//
//  UIImage+WH_EXtension.h
//  WasteHouse
//
//  Created by snowlu on 2018/4/22.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WH_EXtension)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (CGSize )imageWithOriginal:(UIImage *)originalImage ;

@end
