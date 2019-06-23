//
//  NSString+GMExtention.m
//  gmu
//
//  Created by edz on 2018/9/19.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "NSString+GMExtention.h"

@implementation NSString (GMExtention)


+(BOOL)isYearsValidity:(NSString *)year{
    if (year.length==1) {
        return [year hasPrefix:@"1"]||[year hasPrefix:@"2"];
    }else if (year.length ==4){
        NSString *regex = @"(19|20)\\d{2}";
        NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [mobileTest evaluateWithObject:year];
    }else{
        return YES;
    }
}

+(BOOL)isMonthValidity:(NSString *)month{
    if (month.integerValue  >=0 &&  month.integerValue <= 12) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isDaysValidity:(NSString *)day {
    if (day.integerValue  >= 0 &&day.integerValue <= 31) {
        return YES;
    }else{
        return NO;
    }
}


BOOL is_null(id object) {
    
    return (nil == object || [@"" isEqual:object] || [object isKindOfClass:[NSNull class]]);
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

NSString *defaultValueContent(NSString * content ,NSString * defaultValue){
    
    if (is_null(content)) {
        
        return defaultValue;
    }
    return content.length?content:defaultValue;
    
}

+(NSString *)AdapterIphoneX:(NSString *)x{
    
    if (IS_iPhoneX_PTSIZE) {
        return [NSString stringWithFormat:@"%@_x",x];
    }
    return x;
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
NSString* getDocumentsFilePath(const NSString* fileName) {
    
    NSString* documentRoot = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    
    return  [documentRoot stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", fileName]];
}

BOOL checkPathAndCreate(NSString *filePath){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath]){
        return YES;
    }else{
        return [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    if (![formatTime isKindOfClass:[NSString class]]) {
        formatTime = [NSString stringWithFormat:@"%@",formatTime];
    }
    NSDate* date = [formatter dateFromString:formatTime];
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] floatValue];
    
    
    return timeSp;
    
}

+(CGFloat)currentTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    return [datenow timeIntervalSince1970];
}
///

//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];

    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
    
}
+(NSString *)timestampSwitchTime:(NSInteger)timestamp {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}
+(NSString *)convertToStringWtihPlayCount:(NSString *) PlayCount{
    NSString *playSting;
    if ([PlayCount integerValue] < 1000) {
        playSting =PlayCount;
    }
    if ([PlayCount integerValue] < 10000) {
        playSting =[NSString stringWithFormat:@"%.2fk",[PlayCount floatValue]/1000];
    }else if ([PlayCount integerValue] < 100000000){
        playSting = [NSString stringWithFormat:@"%.2fw",[PlayCount floatValue]/10000];
    }else{
        playSting= [NSString stringWithFormat:@"%.2fE",[PlayCount floatValue]/100000000];
    }
    return playSting;
}
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:convertToString(originalString)];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        
        return str;
    }
    return str;
    
}
@end
