//
//  BSColorDefines.h
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#ifndef BSColorDefines_h
#define BSColorDefines_h



#define FontPingFangSC(Size) [UIFont SYPingFangSCRegularFontOfSize:Size]

#define FontPingFangBoldSC(Size) [UIFont  SYPingFangSCSemiboldFontOfSize:Size]
//
#define FontPingFangLG(Size) [UIFont SYPingFangSCLightFontOfSize:Size]

#define FangSCSemiboldFont(Size) [UIFont SYPingFangSCSemiboldFontOfSize:Size]

#define FontNormal(Size) [UIFont systemFontOfSize:Size]



#define  ColorRandom  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


//主色
#define MainColor UIColorFromRGB(0x000000)
//副色
#define DeputyColor UIColorFromRGB(0x666666)

#define  WhileBackgroundColor UIColorFromRGB(0xffffff)

#define  lineBackgroundColor  UIColorFromRGB(0xe6e6e6)

#define BaseViewControllerColor UIColorFromRGB(0xEFEEEE)

#define MainSelectColor UIColorFromRGB(0xFD5771)

#define  MainDisableColor UIColorFromRGB(0xFEA4B2)
#endif /* BSColorDefines_h */
