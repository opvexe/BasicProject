//
//  NSString+GMExtention.h
//  gmu
//
//  Created by edz on 2018/9/19.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GMExtention)

/**
 判断是不是年

 @param year <#year description#>
 @return <#return value description#>
 */
+(BOOL)isYearsValidity:(NSString *)year;

/**
 判断月份

 @param month <#month description#>
 @return <#return value description#>
 */
+(BOOL)isMonthValidity:(NSString *)month;

/**
 判断是天

 @param day <#day description#>
 @return <#return value description#>
 */
+(BOOL)isDaysValidity:(NSString *)day;
/**
 

 @param object <#object description#>
 @return <#return value description#>
 */
BOOL is_null(id object) ;

/**
 

 @param object <#object description#>
 @return <#return value description#>
 */
NSString *convertToString(id object);

/**
 

 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)is_nullString:(NSString *)string;


/**
 

 @param content <#content description#>
 @param defaultValue <#defaultValue description#>
 @return <#return value description#>
 */
NSString *defaultValueContent(NSString * content ,NSString * defaultValue);

/**
 适配苹果X

 @param x x 1.image  -- 1_x.image
 @return return value description
 */
+(NSString *)AdapterIphoneX:(NSString *)x;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;

NSString* getDocumentsFilePath(const NSString* fileName);

BOOL checkPathAndCreate(NSString *filePath);

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//将某个时间戳转化成 时间
#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

+(NSString *)timestampSwitchTime:(NSInteger)timestamp;

+(NSString *)convertToStringWtihPlayCount:(NSString *) PlayCount;

+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString;

/**
 当前时间

 @return <#return value description#>
 */
+(CGFloat)currentTime;
@end
