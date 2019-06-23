 //
//  NSString+LSWMEXtension.m
//  WithMusic
//
//  Created by snowlu on 2017/11/30.
//  Copyright © 2017年 LittleShrimp. All rights reserved.
//

#import "NSString+LSWMEXtension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (LSWMEXtension)

+(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}
+ (NSString*) sha1:(NSString *)strign
{
    const char *cstr = [strign cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:strign.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

BOOL isEmpty(NSString* str) {
    
    if (is_null(str)) {
        return YES;
    }
    
    if([str isKindOfClass:[NSString class]]){
        return [trimString(str) length] <= 0;
    }
    
    return NO;
}

NSString* trimString (NSString* input) {
    NSMutableString *mStr = [input mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    NSString *result = [mStr copy];
    return result;
}

NSString* md5(NSString* input)
{
    if(isEmpty(input)){
        return @"";
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}
NSString* Md532BitLower(NSString* input)
{
    const char *cStr = [input UTF8String];
    
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


NSString* Md532BitUpper(NSString* input)
{
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

NSString* getDocumentsFilePath(const NSString* fileName) {
    
    NSString* documentRoot = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    
    return  [documentRoot stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", fileName]];
}

BOOL checkFileIsExsis(NSString *filePath){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:convertToString(filePath)]){
        return YES;
    }else{
        return NO;
    }
}

BOOL checkPathAndCreate(NSString *filePath){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath]){
        return YES;
    }else{
        return [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

BOOL removeItemAtPath(NSString *filePath){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (checkFileIsExsis(filePath)) {
        
        return [fileManager removeItemAtPath:filePath error:nil];
        
    }else{
        return NO;
    }
}
/**
 *
 *
 *  @param object
 *
 *  @return
 */
BOOL is_null(id object) {
    
    return (nil == object || [@"" isEqual:object] || [object isKindOfClass:[NSNull class]]);
}

NSString *defaultValueContent(NSString * content ,NSString * defaultValue){
    
    if (is_null(content)) {
        
        return defaultValue;
    }
    return content.length?content:defaultValue;
    
}

NSString *convertToString(id object){
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }else if(!object){
        return @"";
    }else if([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }else{
        return [NSString stringWithFormat:@"%@",object];
    }
}
+ (BOOL)is_nullString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)myColor withString:(NSString *)originalString{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        return str;
    }
    return str;
    
}

+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        
        return str;
    }
    return str;
    
}
/**
 
 
 */

+(BOOL)phoneNumberValidity:(NSString *)phone{
    NSString *regex =@"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:phone];
}
+(BOOL)landlinePhoneNumber:(NSString *)phone{
    
    NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return [mobileTest evaluateWithObject:phone];
}
+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font  withString:(NSString *)originalString newString:(NSString *)newString{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        if ([string isEqualToString:newString]) {
            range = NSMakeRange(originalString.length-string.length, string.length);
        }
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        return str;
    }
    return str;
}

NSAttributedString *htmlConvertToString( NSString *object){
    if (object.length &&object) {
        return  [[NSAttributedString alloc] initWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    }
    return nil;
}
NSString *JSONString(NSString *aString)
{
    if (!aString.length) {
        
        return  aString;
    }
    
    
    //    NSMutableString *s = [NSMutableString stringWithString:aString];
    //    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    [s replaceOccurrencesOfString:@":null" withString:@":\"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //
    
    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@":null" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //    return [[NSString stringWithString:s] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [NSString stringWithString:s];
}
NSString *base64EncodeWith(NSString * content){
    
    NSData *dataTake2 =
    [content dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    
    return [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}

NSString *base64DecodeWith(NSString * content){
    
    NSData* decodeData  = [[NSData alloc] initWithBase64EncodedString:content options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
}

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic.count) return nil;
    NSArray *keysArray = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableDictionary *newParamers = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"{"];

    for (NSString *key in keysArray) {
        [newParamers setValue:[dic valueForKey:key] forKey:key];

        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newParamers options:kNilOptions error:&parseError];
        NSString* s = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        s = [s stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        s = [s stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        s = [s stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        s = [s stringByReplacingOccurrencesOfString:@"}" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(s.length-2, 2)];
        s = [s stringByReplacingOccurrencesOfString:@"{" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
        [string appendString:s];
        [string appendString:@","];
        [newParamers removeAllObjects];
    }
    if(string.length > 1) {
        string = [string stringByReplacingOccurrencesOfString:@"," withString:@"" options:0 range:NSMakeRange(string.length-2, 2)];
        [string appendString:@"}"];
    }
    return string;
}
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (!jsonString.length) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)distanceTimeWithBeforeTime:(double)beTime {
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}
+(NSString *)convertToStringWtihPlayCount:(NSString *) PlayCount{
    NSString *playSting;
    if ([PlayCount integerValue] < 10000) {
        playSting =PlayCount;
    }else if ([PlayCount integerValue] < 100000000){
        playSting = [NSString stringWithFormat:@"%.2f万",[PlayCount floatValue]/10000];
    }else{
        playSting= [NSString stringWithFormat:@"%.2f亿",[PlayCount floatValue]/100000000];
    }
    return playSting;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize             = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}
- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
+(NSString *)timeFormatted:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

+(NSString *)timeStringFormatted:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    NSString *hourString = @"";
    if (hours) {
        hourString = [NSString stringWithFormat:@"%d'",hours];
    }
    
    if (minutes) {
        hourString = [NSString stringWithFormat:@"%@%d'",hourString,minutes];
    }
    
    if (seconds) {
        hourString = [NSString stringWithFormat:@"%@%d''",hourString,seconds];
    }
    return hourString;
}

+(NSString *)decodeFromPercentEscapeString: (NSString *) input

{
    if (!input.length) {
        
        return input;
    }
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
+(NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    // Encode all the reserved characters, per RFC 3986
    
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    if (!input.length) {
        
        return input;
    }
    
    NSString *outputStr = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)input,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return outputStr;
    
}
NSString * calculateFileSizeInUnit(unsigned long long contentLength)

{
    if(contentLength >= pow(1024, 3))
        return [NSString stringWithFormat:@"%2.fGB",(float) (contentLength / (float)pow(1024, 3))];
    else if(contentLength >= pow(1024, 2))
        return [NSString stringWithFormat:@"%2.f MB",(float) (contentLength / (float)pow(1024, 2))];
    else if(contentLength >= 1024)
        return [NSString stringWithFormat:@"%2.f KB",(float) (contentLength / (float)1024)];
    else
        return [NSString stringWithFormat:@"%2.f MB",(float) (contentLength)];
}

+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
+(NSString *)ChangedHandsImmediately:(NSString *)phone{
    if (![self phoneNumberValidity:phone]) {
        return  phone;
    }
   return  [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
}

+(NSString *)kindConvertToStringWtihType:(NSString *)Type{
    switch (Type.integerValue) {
        case 1:
            return  @"回收商废料";
            break;
        case 2:
            return  @"企业废料";
            break;
        default:
            return  @"";
            break;
    }
}
@end
