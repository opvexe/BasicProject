//
//  UIFont+WH_Extentsion.h
//  WasteHouse
//
//  Created by snowlu on 2018/4/22.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (WH_Extentsion)
/**
 粗体字体

 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)mediumFontOfSize:(CGFloat)fontSize;

/**
 正常字体
 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)FontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Light

 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)SYPingFangSCLightFontOfSize:(CGFloat)fontSize;


/**
 PingFangSC

 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)SYPingFangSCRegularFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Medium

 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)SYPingFangSCMediumFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Semibold

 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
+ (UIFont *)SYPingFangSCSemiboldFontOfSize:(CGFloat)fontSize;

@end
