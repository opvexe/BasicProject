//
//  BSCommonDefines.h
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#ifndef BSCommonDefines_h
#define BSCommonDefines_h


#define  PlaceholdImageNAME @"photo_placehold"


//weak-self dance

#ifndef weakify

#if __has_feature(objc_arc)

#define weakify(self) autoreleasepool {} __attribute__((objc_ownership(weak))) __typeof__(self) weakSelf = (self)

#endif

#endif



#ifndef strongify

#if __has_feature(objc_arc)

#define strongify(self) try {} @finally {} _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") __attribute__((objc_ownership(strong))) __typeof__(self) self = weakSelf; _Pragma("clang diagnostic pop")

#endif

#endif





#define  BSWMImageNamed(imageName)   [UIImage imageNamed:imageName]



#define  BSWMUserDefaults        [NSUserDefaults standardUserDefaults]



#define  BSWMNotificationCenter      [NSNotificationCenter defaultCenter]



#define delay(block)\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
block();\
});\



#define AppVersion  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]



#define AppBuildVersion  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]



// 格式化字符串

#define FormatString(string, args...)       [NSString stringWithFormat:string, args]



#define URLFromString(str)                      [NSURL URLWithString:str]



#define BSWMLocalString(key) NSLocalizedStringFromTable(key, @"Localizable", nil)



#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]





#define iOS7                                ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)? NO:YES)



#define iOS11 @available(iOS 11.0, *)



#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)



#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)



#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)



#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))



#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))





#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)



#define BSSCALWIDTH (SCREEN_WIDTH/375.0)



#define BSSCALHEIGHT (SCREEN_HEIGHT/667.0)



#define StatusBar_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height



// iPhone X

#define  BSiPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

// Tabbar height.

#define  BSTabbarHeight         (BSiPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.

#define  BSTabbarSafeBottomMargin         (BSiPhoneX ? 34.f : 0.f)



#define NavBarHeight                        (iOS7 ? (BSiPhoneX ? 88.f : 64.f) : 44.0)



#define BSiPhoneXStatusBarHeight                      (BSiPhoneX ? 44.f : 0)



#define StatusBarHeight                     (iOS7 ? (BSiPhoneX ? 44.f : 20.f) : 0.0)



#define Number(num)                      (num*BSSCALWIDTH)



#define NumberHeight(num)                      (num*BSSCALHEIGHT)



#define AutomaticallyAdjustsScrollViewInsetsNO(view) if (@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;}else{self.automaticallyAdjustsScrollViewInsets = NO;}



#define BSViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

// UTF8 字符串

#define UTF8Data(str) [str dataUsingEncoding:NSUTF8StringEncoding]


#ifdef __OBJC__

#ifdef DEBUG

# define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

# define NSLog(...);

#endif
#endif


#endif /* BSCommonDefines_h */
