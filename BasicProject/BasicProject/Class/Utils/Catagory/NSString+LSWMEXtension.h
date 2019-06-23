//
//  NSString+LSWMEXtension.h
//  WithMusic
//
//  Created by snowlu on 2017/11/30.
//  Copyright © 2017年 LittleShrimp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSWMEXtension)
+(NSString*)getCurrentTimestamp;

+ (NSString*) sha1:(NSString *)strign;

/**
 *  判断是否为空对象
 *
 *  @param object 对象
 *
 *
 */
BOOL is_null(id object);
/**
 *  根据对象转化字符串
 *
 *  @param object object description
 *
 *  @return return value description
 */
NSString *convertToString(id object);
/**
 *  判断是否为空string
 *
 *  @param string 对象
 *
 *
 */
+(BOOL)is_nullString:(NSString *)string ;
/**
 *  字符串显示两种颜色
 *
 *  @param string         string description
 *  @param myColor        <#myColor description#>
 *  @param originalString <#originalString description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)myColor withString:(NSString *)originalString;
/**
 *  字符串显示两种颜色
 *
 *  @param string         string description
 *  @param myColor        <#myColor description#>
 *  @param originalString <#originalString description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString;
/**
 *  检测电话号码
 *
 *  @param phone <#phone description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)phoneNumberValidity:(NSString *)phone;



+(BOOL)landlinePhoneNumber:(NSString *)phone;

+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font  withString:(NSString *)originalString newString:(NSString *)newString;

NSAttributedString *htmlConvertToString( NSString *object);

NSString *JSONString(NSString *aString);

NSString *base64EncodeWith(NSString * content);

NSString *base64DecodeWith(NSString * content);

+(NSString*)dictionaryToJson:(NSDictionary *)dic;

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+(NSString *)distanceTimeWithBeforeTime:(double)beTime ;

+(NSString *)convertToStringWtihPlayCount:(NSString *) PlayCount;

/**
 *
 *
 *  @param font
 *  @param maxW
 *
 *  @return
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *
 *
 *  @param font
 *
 *  @return
 */
- (CGSize)sizeWithFont:(UIFont *)font;


NSString *defaultValueContent(NSString * content ,NSString * defaultValue);


NSString* md5(NSString* input);

/**
 Description
 
 @param input input description
 @return return value description
 */
NSString* Md532BitUpper(NSString* input);

/**
 Description
 
 @param input input description
 @return return value description
 */
NSString* Md532BitLower(NSString* input);

NSString* getDocumentsFilePath(const NSString* fileName);

BOOL checkPathAndCreate(NSString *filePath);

BOOL removeItemAtPath(NSString *filePath);

+(NSString *)timeFormatted:(int)totalSeconds;

+(NSString *)timeStringFormatted:(int)totalSeconds ;

+(NSString *)encodeToPercentEscapeString: (NSString *) input;

+(NSString *)decodeFromPercentEscapeString: (NSString *) input;

NSString * calculateFileSizeInUnit(unsigned long long contentLength);

+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
/*
 136*****8676
 **/
+(NSString *)ChangedHandsImmediately:(NSString *)phone;

/**
 转化类型
 @param Type <#Type description#>
 @return <#return value description#>
 */
+(NSString *)kindConvertToStringWtihType:(NSString *)Type;
@end
