//
//  UIFont+WH_Extentsion.m
//  WasteHouse
//
//  Created by snowlu on 2018/4/22.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "UIFont+WH_Extentsion.h"

@implementation UIFont (WH_Extentsion)

+ (UIFont *)mediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:fontSize];
    
}

+ (UIFont *)FontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)SYPingFangSCLightFontOfSize:(CGFloat)fontSize
{

    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

+ (UIFont *)SYPingFangSCRegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)SYPingFangSCMediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)SYPingFangSCSemiboldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

@end
