//
//  UIImage+WH_EXtension.m
//  WasteHouse
//
//  Created by snowlu on 2018/4/22.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "UIImage+WH_EXtension.h"

@implementation UIImage (WH_EXtension)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    if (radius > 0.0f && radius <= size.width && radius <= size.height) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
        [color setFill];
        [path fill];
    } else {
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    }
    CGContextRestoreGState(ctx);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    return [UIImage imageWithColor:color size:size cornerRadius:0.0f];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (CGSize )imageWithOriginal:(UIImage *)originalImage {
    
    return CGSizeMake(originalImage.size.width / [UIScreen mainScreen].scale, originalImage.size.height / [UIScreen mainScreen].scale);
    ;
}

@end
