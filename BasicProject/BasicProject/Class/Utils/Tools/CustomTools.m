//
//  CustomTools.m
//  EMeeting
//
//  Created by AppDev on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTools.h"
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLAvailability.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <AVFoundation/AVFoundation.h>
#include <sys/stat.h>
#include <dirent.h>
#import "MapGeocoder.h"
#import "KeychainItemWrapper.h"

@implementation CustomTools

static NSDateFormatter *dateFormatter;

+(void)destroy{
    CT_SAFERELEASE(dateFormatter);
}

//返回设备剩余空间
+ (long long) freeDiskSpaceInBytesByMB{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace/1024/1024;
}

//获取版本型号
+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1 (GSM)";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G (GSM)";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS (GSM)";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (Rev A)";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM+WCDMA)";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6 plus";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
 
    
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,11"]) return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9 inch 2nd gen";
    if ([deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9 inch 2nd gen";
    if ([deviceString isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5";
    if ([deviceString isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5";
    if ([deviceString isEqualToString:@"iPad7,5"]) return @"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,6"]) return @"iPad 6";
    //mini
    if ([deviceString isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"]) return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
         
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (GSM+LTE)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    DebugNSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+ (NSString*)deviceWithNumString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    @try {
        return [deviceString stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    @catch (NSException *exception) {
        return deviceString;
    }
    @finally {
    }
}

//json序列化
+(NSString*)jsonEncoding:(id)jsonObj{
    NSError *error=nil;
    NSData  *jsonData=[NSJSONSerialization dataWithJSONObject:jsonObj options:kNilOptions error:&error];
    if (jsonData!=nil&&error==nil) {
        return CT_AUTORELEASE([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    }
    else{
        return nil;
    }
}

//json序列化
+(NSData*)jsonEncodingData:(id)jsonObj{
    if (jsonObj == nil) {
        return nil;
    }
    NSError *error=nil;
    NSData  *jsonData=[NSJSONSerialization dataWithJSONObject:jsonObj options:kNilOptions error:&error];
    return jsonData;
}

//字符sha1加密
+(NSString*)SHA1encode:(NSString*)value
{
    const char *cstr = [value cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:value.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;  
}

//文件sha1加密
+(NSString*)FileSHA1encode:(NSString*)path{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil;
    }
    CC_SHA1_CTX sha1;
    CC_SHA1_Init(&sha1);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_SHA1_Update(&sha1, [fileData bytes], (int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(digest, &sha1);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//字符md5加密
+(NSString *)MD5encode:(NSString *)value{
    const char *cstr = [value cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:value.length];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//文件md5加密
+(NSString*)FileMD5Encode:(NSString*)path{
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], (int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//图片尺寸处理
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, 0, image.size.width, image.size.height));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

+(UIImage *)scaleToSize:(UIImage *)img rect:(CGRect)rect {
    CGImageRef sourceImageRef = [img CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

+ (CGSize)getShearSize:(CGSize)orSize {
    CGSize cutSize;
    if (orSize.width > 1080) {
        NSInteger height = orSize.height * 1080 / orSize.width;
        cutSize = CGSizeMake(1080, height);
    }
    else if (orSize.height > 1920) {
        NSInteger width = orSize.width * 1920 / orSize.height;
        cutSize = CGSizeMake(width, 1920);
    }
    else {
        cutSize = orSize;
    }
    return cutSize;
}


+ (CGSize)getShearPicturesSize:(UIImage *)image {
    CGSize imgSize = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
    if (imgSize.width > 1080) {
        NSInteger height = imgSize.height * 1080 / imgSize.width;
        imgSize = CGSizeMake(1080, height);
    }
    else if (imgSize.height > 1920)
    {
        NSInteger width = imgSize.width * 1920 / imgSize.height;
        imgSize = CGSizeMake(width, 1920);
    }
    
    return imgSize;
}

//图片叠加
+(UIImage *)addImage:(UIImage *)image1 rect1:(CGRect)rect1 toImage:(UIImage *)image2 rect2:(CGRect)rect2

{
    
    UIGraphicsBeginImageContext(image2.size);
    
    
    
    //Draw image2
    
    [image2 drawInRect:rect1];
    
    
    
    //Draw image1
    
    [image1 drawInRect:rect1];
    
    
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    
    
    return resultImage;
    
}

//图片竖直方向拼接
+ (UIImage *)addImage:(NSArray *)imageArr{
    float y = 0.0f;
    NSMutableArray *scaleImageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageArr.count; i++) {
        @autoreleasepool {
            UIImage *image = [imageArr objectAtIndex:i];
            float scale = 640.0f/image.size.width;
            UIImage *scaledImage = [CustomTools scaleToSize:image size:CGSizeMake(640.0f, image.size.height*scale)];
            [scaleImageArr addObject:scaledImage];
            y += scaledImage.size.height + 1;
        }
    }
    
    CGSize size = CGSizeMake(640, y);
	
	UIGraphicsBeginImageContext(size);
    
    y = 0;
    for (int i = 0; i < imageArr.count; i++) {
        @autoreleasepool {
            UIImage *image = [scaleImageArr objectAtIndex:i];
            [image drawInRect:CGRectMake(0, y, 640, image.size.height)];
            y += image.size.height + 1;
        }
    }
    [scaleImageArr removeAllObjects];
    CT_RELEASE(scaleImageArr);
    
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
	return resultingImage;
}


//得到数组按指定字符分割
+(NSArray *) GetResultArray:(NSString *)String subBySplitString:(NSString *)splitString{
	if (![String length] || ![splitString length]) {
		return nil;
	}
	else {
		if (![String rangeOfString:splitString].length) {
			return nil;
		}
		return [String componentsSeparatedByString:splitString];
	}
}

//转换字符串为日期
+(NSDate*)StrToDate:(NSString*)dateStr{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ +0000",dateStr]];
}

//转换日期为字符串
+ (NSString *)StringTimeToDate:(NSDate *)theDate toFormat:(NSString*)toFormat{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    
    [dateFormatter setDateFormat:toFormat];
    NSString * timeString = [dateFormatter stringFromDate:theDate];
    return timeString;
}

+ (NSString *)StringTimeToDate:(NSString *)theDate fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:fromFormat];
    NSDate *d=[dateFormatter dateFromString:theDate];
    
    [dateFormatter setDateFormat:toFormat];
    NSString * timeString = [dateFormatter stringFromDate:d];

    return timeString;
}

+ (NSDate *)StringTimeToDate:(NSString *)theDate fromFormat:(NSString*)fromFormat{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:fromFormat];
    return [dateFormatter dateFromString:theDate];
}
//Unix日期格式化

+ (NSString *)UnixTimeToDate:(NSString *)theDate{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    NSDate * d = [NSDate dateWithTimeIntervalSince1970:[theDate floatValue]];
    NSString * timeString = [dateFormatter stringFromDate:d];
    return timeString;
}

//日期差值计算
+ (NSString *)intervalSinceNow:(NSString *)theDate date:(NSDate *)data
{
    if (dateFormatter==nil) {
        dateFormatter=[[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:sszzz"];
    NSDate *d=[dateFormatter dateFromString:theDate];
    if (data != nil) {
        d = data;
    }
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    if (cha/60 < 0)
    {
        timeString = [NSString stringWithFormat:@"1秒前"];
    }
    if (cha/60 > 0&&cha/60 < 1)
    {
        timeString = [NSString stringWithFormat:@"%f",fabs(cha / 60)];
        timeString = [timeString substringToIndex:timeString.length - 7];
        float theTime = [timeString floatValue] * 10 + 1;
        timeString = [NSString stringWithFormat:@"%.f秒前",theTime];
    }
    
    if(cha / 3600 < 1 && cha / 60 > 1){
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    if(cha / 3600 > 1 && cha / 86400 < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if(cha / 86400 >1 && cha/ (86400 * 31) < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    if(cha / (86400 * 31) >1 && cha / (86400 * 31 * 12) < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/(86400 * 31)];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@月前", timeString];
    }
    
    if(cha / (86400 * 31 * 12) >1){
        timeString = [NSString stringWithFormat:@"%f", cha/(86400 * 31 * 12)];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@年前", timeString];
    }
    return timeString;
}

+ (NSString *)intervalSinceNowWithUnix:(NSString *)theDate
{
    NSTimeInterval late=[theDate floatValue];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    if (cha/60 < 0)
    {
        timeString = [NSString stringWithFormat:@"1秒前"];
    }
    if (cha/60 > 0&&cha/60 < 1)
    {
        timeString = [NSString stringWithFormat:@"%f",fabs(cha / 60)];
        timeString = [timeString substringToIndex:timeString.length - 7];
        float theTime = [timeString floatValue] * 10 + 1;
        timeString = [NSString stringWithFormat:@"%.f秒前",theTime];
    }
    
    if(cha / 3600 < 1 && cha / 60 > 1){
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    if(cha / 3600 > 1 && cha / 86400 < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if(cha / 86400 >1 && cha/ (86400 * 31) < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    if(cha / (86400 * 31) >1 && cha / (86400 * 31 * 12) < 1){
        timeString = [NSString stringWithFormat:@"%f", cha/(86400 * 31)];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@月前", timeString];
    }
    
    if(cha / (86400 * 31 * 12) >1){
        timeString = [NSString stringWithFormat:@"%f", cha/(86400 * 31 * 12)];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@年前", timeString];
    }
    return timeString;
}

//图文混排
#define BEGIN_FLAG @"["
#define END_FLAG @"]"
+(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}


+(NSString*)SecureRandom:(int)length {
    char data[length];
    for (int x=0;x<length;x++){
        switch (arc4random_uniform(3)) {
            case 0:
                data[x] = (char)('A' + (arc4random_uniform(26)));
                break;
            case 1:
                data[x] = (char)('a' + (arc4random_uniform(26)));
                break;
            case 2:
                data[x] = (char)('0' + (arc4random_uniform(10)));
                break;
            default:
                break;
        }
    };
    return CT_AUTORELEASE([[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding]);
}

+(NSString *)HMACSha1:(NSString *)text secret:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}

+ (NSString *)getfileImgName {
    NSString * uuid =[[NSUUID UUID] UUIDString];
    NSDate * date = [[NSDate alloc]init];
    NSString * timeDate = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    
    
    return [self MD5encode:[NSString stringWithFormat:@"%@%@",uuid,timeDate]];
}


//图片镜像翻转
+ (UIImage *)flipMirrorImage:(UIImage *)img  {
    NSInteger xxx = img.size.width;
    NSInteger yyy = img.size.height;

    CGRect rect = CGRectMake(0, 0, xxx, yyy);//创建矩形框
    UIGraphicsBeginImageContext(rect.size);//根据size大小创建一个基于位图的图形上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();//获取当前quartz 2d绘图环境
    CGContextClipToRect(currentContext, rect);//设置当前绘图环境到矩形框
    
    
    CGContextRotateCTM(currentContext, M_PI);
    CGContextTranslateCTM(currentContext, -rect.size.width, -rect.size.height);
    
    CGContextDrawImage(currentContext, rect, img.CGImage);//绘图
    
    //[image drawInRect:rect];
    
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();//获得图片
    UIGraphicsEndImageContext();//从当前堆栈中删除quartz 2d绘图环境
    
    
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:rect];
    contentView.image=cropped;
    
    contentView.transform = CGAffineTransformIdentity;
    contentView.transform = CGAffineTransformMakeScale(-1.0, 1.0);


    
    
    return contentView.image;
}



+ (long long) folderSizeAtPath3:(NSString*) folderPath{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [folderPath stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            [self folderSizeAtPath3:fullPath];
        }
    }
    return size;
}
//Private
+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = (int)strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}


//UIView转化成UIImage
+ (UIImage*)convertViewToImage:(UIView*)orView{
    
    
    
    UIGraphicsBeginImageContext(orView.bounds.size);
    
    [orView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//图片尺寸处理
+(UIImage *)scaleToRectAndView:(UIView *)view rect:(CGRect)rect {
    
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = [image CGImage];
    CGRect editRect = CGRectMake(0, rect.origin.y * [UIScreen mainScreen].scale, rect.size.width * [UIScreen mainScreen].scale, rect.size.height * [UIScreen mainScreen].scale);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, editRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
    
}

+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
     // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view = nil;
    size = CGSizeZero;
    return image;
    
}


/*
 规则（当前时间＋0～999随机数）转md5 ＋ uuid
 */
+ (NSString *)getTimeAndUUID {
    
    NSString * resultStr;
    NSString * arcStr = [NSString stringWithFormat:@"%u",arc4random()%999];
    
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [[dateFormatter stringFromDate:nowDate] stringByAppendingString:arcStr];
    
    resultStr = [NSString stringWithFormat:@"%@%@",[self MD5encode:destDateString],[self uuid]];
    
    return resultStr;
}

+ (NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%lld", (long long)(date.timeIntervalSince1970)];
    
    return timestamp;
}

+ (NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


+ (BOOL)isAllowedNotification {
    
    //iOS8 check if user allow notification
    
    if(CURRENT_SYSTEM_VERSION >= 8) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if
            (UIUserNotificationTypeNone != setting.types) {
                
                return
                YES;
            }
    }
    else
    {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if(UIRemoteNotificationTypeNone != type)
            
            return
            YES;
    }
    
    return
    NO;
}



+ (NSString *)accessOriginalImageUrl:(NSURL *)url {
    if (url) {
        
        NSString * originalUrlStr;
        NSRange rangeJpg = [[NSString stringWithFormat:@"%@",url] rangeOfString:@".jpg?"];
        if (rangeJpg.length > 0) {
            originalUrlStr = [[NSString stringWithFormat:@"%@",url] substringToIndex:rangeJpg.location + 5];
        }
        
        NSRange rangePng = [[NSString stringWithFormat:@"%@",url] rangeOfString:@".png?"];
        if (rangePng.length > 0) {
            originalUrlStr = [[NSString stringWithFormat:@"%@",url] substringToIndex:rangePng.location + 5];
        }
        
        
        return originalUrlStr;
    }
    else
    {
        return nil;
    }

}


+ (BOOL)validatePhone:(NSString *)phone {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    BOOL res2 = [regextestcm evaluateWithObject:phone];
    BOOL res3 = [regextestcu evaluateWithObject:phone];
    BOOL res4 = [regextestct evaluateWithObject:phone];
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIImage *)blurryImage:(UIImage *)orimage level:(CGFloat)level {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:orimage];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:level] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}


+ (void)jumpToAppStoreScore {
//    NSString * appIDstr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&id=%@",AppID];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appIDstr]];
}


+ (CGRect)getStringSize:(NSString *)messageStr fontNum:(CGFloat)fontNum maxWidth:(CGFloat)maxWidth maxheight:(CGFloat)maxheight {
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontNum]};
    return [self calculateStringSize:messageStr attributes:attributes maxWidth:maxWidth maxheight:maxheight];
}

+ (CGRect)getStringSize:(NSString *)messageStr font:(UIFont *)font maxWidth:(CGFloat)maxWidth maxheight:(CGFloat)maxheight {
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    return [self calculateStringSize:messageStr attributes:attributes maxWidth:maxWidth maxheight:maxheight];
}

+ (CGRect)calculateStringSize:(NSString *)messageStr attributes:(NSDictionary *)attributes maxWidth:(CGFloat)maxWidth maxheight:(CGFloat)maxheight {
    CGRect rectlabMessage = [messageStr boundingRectWithSize:CGSizeMake(maxWidth, maxheight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return rectlabMessage;
}



/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
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


+ (NSString *)intervalSinceNow:(NSDate *)fromDate
{
    NSString *timeString=@"";
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = labs((long)intervalTime);
    NSInteger iSeconds =  lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = labs(lTime/3600);
    
    
    NSString * strHours = [NSString stringWithFormat:@"%ld",(long)iHours];
    NSString * strMinutes = [NSString stringWithFormat:@"%ld",(long)iMinutes];
    NSString * strSeconds = [NSString stringWithFormat:@"%ld",(long)iSeconds];
    
    return [NSString stringWithFormat:@"%@:%@:%@",[self oneLenghtStrChangeTwoLenght:strHours],[self oneLenghtStrChangeTwoLenght:strMinutes],[self oneLenghtStrChangeTwoLenght:strSeconds]];
}

+ (NSString *)oneLenghtStrChangeTwoLenght:(NSString *)str {
    NSString * result = @"";
    result = str;
    if (str.length == 1) {
        result = [NSString stringWithFormat:@"0%@",str];
    }
    return result;
}


+ (NSDate *)tDate:(NSDate *)date

{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];

    return localeDate;
    
}




//获取域名
+ (NSString *)getAddress:(NSString *)address {
    //提取出域名
    NSMutableString *string = [NSMutableString stringWithString:address];
    NSRange r1 = [string rangeOfString:@"rtmp://"];
    [string deleteCharactersInRange:r1];
    NSRange r2 = [string rangeOfString:@"/"];
    
    return [string substringToIndex:r2.location];
}






+ (UIImage *)fixOrientation:(UIImage *)img {
    
    // No-op if the orientation is already correct
    if (img.imageOrientation == UIImageOrientationUp) return img;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (img.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, img.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, img.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (img.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, img.size.width, img.size.height,
                                             CGImageGetBitsPerComponent(img.CGImage), 0,
                                             CGImageGetColorSpace(img.CGImage),
                                             CGImageGetBitmapInfo(img.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (img.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,img.size.height,img.size.width), img.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,img.size.width,img.size.height), img.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *resultImg = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return resultImg;
}


//根据视频的URL截取第一帧图
+ (UIImage *)getImage:(NSString *)videoURL
{
    if (is_null(videoURL))return nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(1, 30);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

+ (UIImage*)imageFromSdcache:(NSURL*)imageURl{

    BOOL isExit = [[SDWebImageManager sharedManager] cachedImageExistsForURL:imageURl];
    if(isExit) {
        NSString * cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURl];
        UIImage * memoryCacheImage =  [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:cacheImageKey];
        if (memoryCacheImage) {
            return memoryCacheImage;
        }
        UIImage * diskCacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheImageKey];
        if (diskCacheImage) {
           return diskCacheImage;
        }
    }
    return nil;
}






/**
 *  根据生日计算星座
 *
 *  @param month 月份
 *  @param day   日期
 *
 *  @return 星座名称
 */
+ (NSString *)getConstellationWithTimestamp:(NSInteger)month day:(NSInteger)day {
    NSString *astroString = @"摩羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手摩羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
}



/**
 * 根据NSDate计算年龄
 */
+ (NSInteger)getAgefromDate:(NSDate * )date {
    //计算年龄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = date;
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSTimeInterval time = [currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    return age;
}



+(NSInteger)getAgeFromDateTime:(CGFloat )time  currentTime:(CGFloat)curentTime {
    
    CGFloat tempTime = curentTime  - time;

    
    return  ((int)tempTime)/(3600*24*365);
}

/**
 * 等级需要的经验值
 */
+ (int)expWithLevel:(int)level {
    return (int) (150 * pow(1.2, level));
}


//获取时间段
+ (NSString *)getTheTimeBucket:(NSDate *)currentDate {
    
    if ([currentDate compare:[self getCustomDateWithHour:0]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:9]] == NSOrderedAscending)
    {
        return @"早上";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:9]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:11]] == NSOrderedAscending)
    {
        return @"上午";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:11]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:13]] == NSOrderedAscending)
    {
        return @"中午";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:13]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:18]] == NSOrderedAscending)
    {
        return @"下午";
    }
    else
    {
        return @"晚上";
    }
}


+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate * destinationDateNow = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:destinationDateNow];
    
    //设置当前的时间点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}



+ (BOOL)isToday:(NSDate *)date {
    
    if (date) {
        
        
        NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        
        if([today day] == [otherDay day] &&
           [today month] == [otherDay month] &&
           [today year] == [otherDay year] &&
           [today era] == [otherDay era]) {
            return YES;
        }else{
            return NO;
        }
    }
    else {
        return NO;
    }   
}

+ (BOOL)isYesterday:(NSDate *)date {

    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDate * refDate = date;
    
    // 10 first characters of description is the calendar date:
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * refDateString = [[refDate description] substringToIndex:10];
    
    if ([refDateString isEqualToString:yesterdayString])
    {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isWeekday:(NSDate *)date {
    
    NSDate *nowDate = [NSDate date];
    
    //2014-04-30
    NSDate *selfDate = date;
    
    //获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day <= 7;
    
    
}

+ (NSString *)getYearDay:(NSDate *)date

{
 
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger day = [components day];
    
    NSInteger month= [components month];
    
    NSInteger year= [components year];
    
    
    
    return [NSString stringWithFormat:@"%d/%d/%ld",(int)year,(int)month,(long)day];
    
}

+ (NSString *)getDayMonth:(NSDate *)date

{
    
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger day = [components day];
    
    NSInteger month= [components month];

    return [NSString stringWithFormat:@"%02d/%d月",(int)day,(int)month];
    
}
//获取当前时间到明天的时间差
+ (double)getgapToTomorrow:(NSDate *)date {
    NSString *tomorrowDayStr = [self StringTimeToDate:date toFormat:@"hh:mm:ss"];
    NSArray *array = [tomorrowDayStr componentsSeparatedByString:@":"];
    double gap = 0;
    for (int i=0; i<array.count; i++) {
        if (i==0) {
          gap = gap+ 3600*(23-[[array objectAtIndex:i] integerValue]);
        }
        if (i==1) {
          gap = gap+ 60*(59-[[array objectAtIndex:i] integerValue]);
        }
        if (i==2) {
          gap = gap+ (59-[[array objectAtIndex:i] integerValue]);
        }
    }
    
    return gap;
}
+ (NSInteger)getlastDaysInThisMonth:(NSDate *)date {
    if (date == nil) {
        return 31;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger day = [components day];
    
    NSInteger month= [components month];
    
    NSInteger year = [components year];
    BOOL isYun = NO;
    //普通年份，非100整数倍
    if(year%4==0 && year%100!=0){
        isYun = YES;
    }else {
        isYun = NO;
    }
    //世纪年份
    if(year%400 == 0) {
        isYun = YES;
    }else {
        isYun = NO;
    }
    NSInteger monthDay = 31;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            monthDay = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            monthDay =  30;
            break;
        case 2:
            if (isYun) {
                monthDay =  29;
            }else {
                monthDay =  28;
            }
            break;
        default:
            monthDay = 31;
            break;
    }
    NSInteger lastDay = monthDay - day;
    
    return lastDay;
}
+ (NSString *)getDiaryModelmonthAndDay:(NSDate *)date

{
    
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger day = [components day];
    
    NSInteger month= [components month];
    
    
    return [NSString stringWithFormat:@"%d月%ld号",(int)month,(long)day];
    
}

+ (NSString *)getDiaryModelYearAndMonthAndDay:(NSDate *)date

{
    
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger year = [components year];
    
    NSInteger day = [components day];
    
    NSInteger month= [components month];
    
    
    return [NSString stringWithFormat:@"%d年%d月%ld号",(int)year,(int)month,(long)day];
    
}

+ (NSString *)getDiaryModelHouerAndminute:(NSDate *)date

{
    
    if (date == nil) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    
    NSInteger hour = [components hour];
    
    NSString * minuteStr = [NSString stringWithFormat:@"%ld",(long)[components minute]];
    if (minuteStr.length <= 1) {
        minuteStr = [NSString stringWithFormat:@"0%@",minuteStr];
    }
    
    return [NSString stringWithFormat:@"%d:%@",(int)hour ,minuteStr];
    
}

//跟经纬度 算 距离
+ (NSString *)distanceLat:(UserInfo *)userInfo {
    NSString * distanceString = [NSString stringWithFormat:@"%@",userInfo.distance];
    if ([userInfo.user_id isEqualToString:[LocalUserInfo getUserInfo].user_id]) {
        distanceString = @"0.00 km";
    }
    else {
        if (userInfo.type == 2) {
            //客服
            distanceString = CustomValueStr(@"在你心里");
        }
        else {
            //普通用户
            double distanceDouble = [distanceString doubleValue];
            if (userInfo.status == 0 || userInfo.status == 2) {
                //被处理用户
                distanceString = @".";
            }
            else {
                //正常用户
                if (distanceDouble < 1 && distanceDouble > 0) {
                    distanceString = [NSString stringWithFormat:@"%.f m",distanceDouble * 1000];
                }else if(distanceDouble == 0){
                    distanceString = @"在你怀里";
                }else{
                    distanceString = [NSString stringWithFormat:@"%.2f km",distanceDouble];
                }
                
            }
        }
    }
    
    return distanceString;
}

//跟经纬度 算 距离
+ (NSString *)newDistanceLat:(UserInfo *)userInfo {
    NSString * distanceString = [NSString stringWithFormat:@"%@",userInfo.distance];
    if ([userInfo.user_id isEqualToString:[LocalUserInfo getUserInfo].user_id]) {
        distanceString = @"0.00km";
    }
    else {
        if (userInfo.type == 2) {
            //客服
            distanceString = CustomValueStr(@"在你心里");
        }
        else {
            //普通用户
            double distanceDouble = [distanceString doubleValue];
            
            if (distanceDouble < 0.002f) {
                distanceString = @"在你怀里";
            }else{
                //正常用户
                if (distanceDouble <= 1) {
                    distanceString = [NSString stringWithFormat:@"%.fm",distanceDouble * 1000];
                }else{
                    distanceString = [NSString stringWithFormat:@"%.2fkm",distanceDouble];
                }
            }
        }
    }
    
    return distanceString;
}

+ (void)analysisAddressWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude withLocality:(BOOL)locality andResult:(void(^)(NSString* address))result {
    CGFloat latitude_wgs = latitude;
    CGFloat longitude_wgs = longitude;
    CLLocation * location = [[CLLocation alloc] initWithLatitude:latitude_wgs longitude:longitude_wgs];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks == nil || error) {
            if (result) {
                result(nil);
            }
            return ;
        }
        CLPlacemark * place = [placemarks objectAtIndex:0];
        
        NSString * address = [[NSString alloc] init];
        if (place.country) {// 中国
            
        }
        if (place.administrativeArea) {// 河南省
    
        }
        if (place.locality) {// 郑州市
            if (locality) {
                address = [address stringByAppendingString:place.locality];
                address = [address stringByAppendingString:@", "];
            }
        }
        if (place.subLocality) {// 金水区
            address = [address stringByAppendingString:place.subLocality];
        }
        if (place.thoroughfare) {//人民路
            
        }
        if (place.subThoroughfare) {// 12-10号
            
        }
        if (result) {
            result(address);
        }
    }];
    

}


+ (long long) fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/*
 style == 0匹配
 style == 1聊天 文字
 style == 2聊天 图片
 style == 3聊天 语音
 style == 4弹幕
 */
// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)style msg:(NSString *)msg name:(NSString *)name {
    
    //1.2.0 废弃 由服务器发送APNS
    return;
}







+ (NSArray *)getTagArray:(NSString *)tags {
    NSArray * tags_array = [tags componentsSeparatedByString:@"|"];
    return tags_array;
}

+ (NSString *)isShowLike:(NSString *)likeNumStr {
    if (![likeNumStr isKindOfClass:[NSString class]] || likeNumStr == nil || [likeNumStr isEqualToString:@"(null)"] || [likeNumStr isEqualToString:@"0"] || likeNumStr.integerValue < 0) {
        return @"0";
    }
    CGFloat likeNum = [likeNumStr floatValue];
    if (likeNum < 1000) {
        return likeNumStr;
    }
    else if (likeNum >= 1000 && likeNum < 10000) {
        likeNum = likeNum/100.0;
        int aa = (int)likeNum;
        CGFloat bb = (CGFloat)aa;
        if (aa%10 == 0) {
            return [NSString stringWithFormat:@"%dk",aa/10];
        }
        else {
            return [NSString stringWithFormat:@"%.1fk",bb/10];
        }
    }
    else if (likeNum >= 10000 && likeNum < 100000) {
        likeNum = likeNum/1000.0;
        int aa = (int)likeNum;
        CGFloat bb = (CGFloat)aa;
        if (aa%10 == 0) {
            return [NSString stringWithFormat:@"%dW",aa/10];
        }
        else {
            return [NSString stringWithFormat:@"%.1fW",bb/10];
        }
        
    }
    else if (likeNum >= 100000 && likeNum < 1000000) {
        likeNum = likeNum/10000.0;
        int aa = (int)likeNum;
        return [NSString stringWithFormat:@"%dW",aa];
    }
    else {
        return @"99W";
    }
}


+ (NSString *)isNewShowLike:(NSString *)likeNumStr {
    if (is_null(likeNumStr)) {
        return @"0";
    }
    CGFloat likeNum = [likeNumStr floatValue];
    if (likeNum < 1000) {
        return likeNumStr;
    }
    else if (likeNum >= 1000 && likeNum < 1000000) {
        if ((NSInteger)likeNum %1000 == 0) {
            return [NSString stringWithFormat:@"%ldk",(NSInteger)likeNum /1000];
        }else{
         return [NSString stringWithFormat:@"%.1fk", round(likeNum / 1000 * 100) / 100.0];
        }
    }
    else {
        return [NSString stringWithFormat:@"%.1fM", round(likeNum / 1000000 * 100) / 100.0];
    }
}


+ (NSString *)dateTransformFromString:(NSString*)dateString
{  
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSDate * date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return  currentDateStr;
}


+ (unsigned long)nsstringToNum:(NSString *)str {
    NSString * colorStr = [self convertStringToHexStr:str];
    unsigned long color = strtoul([colorStr UTF8String],0,0);
    return color;
}

+ (NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSString * hexStr = [str stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    
    return hexStr;
}









+ (NSDate *)nsstringToDate:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

//兼用1.1.4需要
+ (NSString *)getIntentWithIntentID:(NSString *)intentID {
    NSInteger intentIDNum = [intentID integerValue];
    NSString * title = @"隐私";
    if (intentIDNum == 1) {
        title = @"宅";
    }
    else if (intentIDNum == 2)
    {
        title = @"旅游";
    }
    else if (intentIDNum == 3)
    {
        title = @"恋爱";
    }
    else if (intentIDNum == 4)
    {
        title = @"约饭";
    }
    else if (intentIDNum == 5)
    {
        title = @"购物";
    }
    else if (intentIDNum == 6)
    {
        title = @"宠物";
    }
    else if (intentIDNum == 7)
    {
        title = @"遛狗";
    }
    else if (intentIDNum == 8)
    {
        title = @"下午茶";
    }
    else if (intentIDNum == 9)
    {
        title = @"阅读";
    }
    else if (intentIDNum == 10)
    {
        title = @"追剧";
    }
    else if (intentIDNum == 11)
    {
        title = @"不看脸";
    }
    else if (intentIDNum == 12)
    {
        title = @"辣妈";
    }
    else if (intentIDNum == 13)
    {
        title = @"骑行";
    }
    else if (intentIDNum == 14)
    {
        title = @"户外";
    }
    else if (intentIDNum == 15)
    {
        title = @"篮球";
    }
    else if (intentIDNum == 16)
    {
        title = @"足球";
    }
    else if (intentIDNum == 17)
    {
        title = @"健身";
    }
    else if (intentIDNum == 18)
    {
        title = @"跑步";
    }
    else if (intentIDNum == 19)
    {
        title = @"游泳";
    }
    else if (intentIDNum == 20)
    {
        title = @"极限运动";
    }
    else if (intentIDNum == 21)
    {
        title = @"高尔夫";
    }
    else if (intentIDNum == 22)
    {
        title = @"改装";
    }
    else if (intentIDNum == 23)
    {
        title = @"网球";
    }
    else if (intentIDNum == 24)
    {
        title = @"游艇";
    }
    else if (intentIDNum == 25)
    {
        title = @"台球";
    }
    else if (intentIDNum == 26)
    {
        title = @"钓鱼";
    }
    else if (intentIDNum == 27)
    {
        title = @"乐器";
    }
    else if (intentIDNum == 28)
    {
        title = @"美术";
    }
    else if (intentIDNum == 29)
    {
        title = @"跳舞";
    }
    else if (intentIDNum == 30)
    {
        title = @"摄影";
    }
    else if (intentIDNum == 31)
    {
        title = @"写作";
    }
    else if (intentIDNum == 32)
    {
        title = @"演唱";
    }
    else if (intentIDNum == 33)
    {
        title = @"艺术展";
    }
    else if (intentIDNum == 34)
    {
        title = @"音乐会";
    }
    else if (intentIDNum == 35)
    {
        title = @"游戏";
    }
    else if (intentIDNum == 36)
    {
        title = @"演唱会";
    }
    else if (intentIDNum == 37)
    {
        title = @"棋牌";
    }
    else if (intentIDNum == 38)
    {
        title = @"KTV";
    }
    else if (intentIDNum == 39)
    {
        title = @"求聊天";
    }
    else if (intentIDNum == 40)
    {
        title = @"酒吧";
    }
    else if (intentIDNum == 41)
    {
        title = @"电影";
    }
    else if (intentIDNum == 42)
    {
        title = @"Party";
    }
    else if (intentIDNum == 43)
    {
        title = @"宅";
    }
    else if (intentIDNum == 44)
    {
        title = @"足控";
    }
    else if (intentIDNum == 45)
    {
        title = @"字母圈";
    }
    else if (intentIDNum == 46)
    {
        title = @"男同志";
    }
    else if (intentIDNum == 47)
    {
        title = @"女同志";
    }
    else if (intentIDNum == 48)
    {
        title = @"释放";
    }
    else if (intentIDNum == 49)
    {
        title = @"机车";
    }
    else if (intentIDNum == 50)
    {
        title = @"野战";
    }
    else if (intentIDNum == 51)
    {
        title = @"PPP";
    }
    else if (intentIDNum == 52)
    {
        title = @"Livehouse";
    }
    else if (intentIDNum == 53)
    {
        title = @"滑板";
    }
    else if (intentIDNum == 54)
    {
        title = @"占卜";
    }
    else
    {
        title = @"放空";
    }
    
    return title;
}





+ (NSString *)getWeekdayStr:(NSInteger)weekday {
    if (weekday == 1) {
        return @"星期日";
    }
    else if (weekday == 2) {
        return @"星期一";
    }
    else if (weekday == 3) {
        return @"星期二";
    }
    else if (weekday == 4) {
        return @"星期三";
    }
    else if (weekday == 5) {
        return @"星期四";
    }
    else if (weekday == 6) {
        return @"星期五";
    }
    else if (weekday == 7) {
        return @"星期六";
    }
    else {
        return @"未知日期";
    }
}

+(NSString *)dealWithString:(NSString *)number
{
    NSString *doneTitle = @"";
    int count = 0;
    for (int i = 0; i < number.length; i++) {
        
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == 3) {
            doneTitle = [NSString stringWithFormat:@"%@,", doneTitle];
        }
    }
    return doneTitle;
}

+ (NSArray *)imageNameToUIimageWithTitle:(NSString *)title gifNum:(NSInteger)gifNum noCache:(BOOL)isNoCache {
    NSArray * array = [self gitArrayWithTitle:title gifNum:gifNum];
    NSMutableArray * gifArray = [[NSMutableArray alloc] init];
   
    for (int i = 0; i < [array count]; i++) {
        @autoreleasepool {
            
            UIImage * img = nil;
            if (isNoCache) {
                NSString *tileName = [array objectAtIndex:i];
                NSString *path = [[NSBundle mainBundle] pathForResource:tileName ofType:@"png"];
                img = [UIImage imageWithContentsOfFile:path];
            }
            else {
                img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]]];
            }
            if (!img) {
                 return [gifArray copy];
            }else{
                [gifArray addObject:img];
            }
        }
    }
    return [gifArray copy];
}

+ (NSArray *)imageNameToUIimageWithTitle:(NSString *)title endNum:(NSInteger)endNum startNum:(NSInteger)startNum noCache:(BOOL)isNoCache {
    NSArray * array = [self gitArrayWithTitle:title endNum:endNum startNum:startNum];
    NSMutableArray * gifArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++) {
        @autoreleasepool {
            UIImage * img = nil;
            NSString *tileName;
            if (isNoCache) {
                tileName = [array objectAtIndex:i];
                NSString *path = [[NSBundle mainBundle] pathForResource:tileName ofType:@"png"];
                img = [UIImage imageWithContentsOfFile:path];
            }
            else {
                img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]]];
            }
            if (img == nil) {
                NSLog(@"%@图片出问题",tileName);
                return gifArray;
            }else {
                [gifArray addObject:img];
            }
        }
    }
    return [gifArray copy];
}

+ (NSArray *)gitArrayWithTitle:(NSString *)title endNum:(NSInteger)endNum startNum:(NSInteger)startNum {
    //假如开始 10 结束 20
    NSInteger allNum = endNum - startNum;
    NSMutableArray * gifArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < allNum; i++) {
        [gifArray addObject:[NSString stringWithFormat:@"%@%ld",title,startNum + i]];
    }
    NSArray * gif = [[NSArray alloc] initWithArray:gifArray];
    return gif;
}


+ (NSArray *)gitArrayWithTitle:(NSString *)title gifNum:(NSInteger)gifNum{
    NSMutableArray * gifArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < gifNum; i++) {
        [gifArray addObject:[NSString stringWithFormat:@"%@%d",title,i]];
    }
    NSArray * gif = [[NSArray alloc] initWithArray:gifArray];
    return gif;
}

+ (CFAbsoluteTime)markStartTime {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    return startTime;
}

+ (CGFloat)markEndTimeWithStartTime:(CFAbsoluteTime)startTime {
    
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    
    return linkTime * 1000.0;
    NSLog(@"执行时间: %f ms", linkTime * 1000.0);
}

//-1 就是 只加webp
//0 就是 不切图 但是有q 和 webp
//-2 就是 没什么都没有
//根据正常图片地址 获取 转换为webp 并且压缩后的 图片地址
+ (NSURL *)urlWithWebPString:(NSString *)urlStr imageWidth:(CGFloat)imageWidth {
    
    NSString * urlWebPStr = @"";
    if (imageWidth > 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@@w_%d,%@",urlStr,(int)imageWidth,NetImageQuality];
    }
    else if (imageWidth == 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@@%@",urlStr,NetImageQuality];
    }
    else if (imageWidth == -1) {
        urlWebPStr = [NSString stringWithFormat:@"%@@",urlStr];
    }
    else {
        urlWebPStr = urlStr;
    }
    
    NSURL * url = [NSURL URLWithString:urlWebPStr];
    return url;
}

//-1 就是 只加webp
//0 就是 不切图 但是有q 和 webp
//-2 就是 没什么都没有
//根据正常图片地址 获取 转换为webp 并且压缩后的 图片地址
+ (NSURL *)tengxunurlWithWebPString:(NSString *)urlStr imageWidth:(CGFloat)imageWidth {
    
    NSString * urlWebPStr = @"";
    if (imageWidth > 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/%@/%@/%@%d",urlStr,TENGXUNNetImageFormWithWebP,TENGXUNNetImageQuality,TENGXUNNetImageWidth,(int)imageWidth];
    }
    else if (imageWidth == 0) {
         urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/%@/%@",urlStr,TENGXUNNetImageFormWithWebP,TENGXUNNetImageQuality];
        
    }
    else if (imageWidth == -1) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/%@",urlStr,TENGXUNNetImageFormWithWebP];
    }
    else {
        urlWebPStr = urlStr;
    }
    
    NSURL * url = [NSURL URLWithString:urlWebPStr];
    return url;
}

+ (NSURL *)qiniuurlWithWebPString:(NSString *)urlStr imageWidth:(CGFloat)imageWidth {

    NSString * urlWebPStr = @"";
    if (imageWidth > 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/3/w/%0.f/%@/interlace/1/ignore-error/1",urlStr,imageWidth,QINIUNetImageQuality];
    }
    else if (imageWidth == 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/0/%@",urlStr,QINIUNetImageFormWithWebP];
        
    }
    else if (imageWidth == -1) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/0/%@",urlStr,QINIUNetImageFormWithWebP];
    }
    else {
        urlWebPStr = urlStr;
    }
    
    NSURL * url = [NSURL URLWithString:urlWebPStr];
    return url;
}
+ (NSURL *)ugcUrlWithWebPString:(NSString *)urlStr imageWidth:(CGFloat)imageWidth {
  //ugc 走七牛的服务
    
    NSString * urlWebPStr = @"";
    if (imageWidth > 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/3/w/%0.f/%@/interlace/1/ignore-error/1",urlStr,imageWidth,TENGXUNNetImageQuality];
    }
    else if (imageWidth == 0) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/0/%@",urlStr,QINIUNetImageFormWithWebP];
        
    }
    else if (imageWidth == -1) {
        urlWebPStr = [NSString stringWithFormat:@"%@?imageView2/0/%@",urlStr,QINIUNetImageFormWithWebP];
    }
    else {
        urlWebPStr = urlStr;
    }
    
    NSURL * url = [NSURL URLWithString:urlWebPStr];
    return url;
    
}
+ (NSURL *)urlWithWebPString:(NSString *)urlStr imageWidth:(CGFloat)imageWidth withType:(NSString*)type
{
    if([type isEqualToString:@"qq"]){
         return  [self tengxunurlWithWebPString:urlStr imageWidth:imageWidth];
    }
    else if([type isEqualToString:@"qiniu"]){
         return  [self qiniuurlWithWebPString:urlStr imageWidth:imageWidth];
    }
    else{
         return  [self urlWithWebPString:urlStr imageWidth:imageWidth*imageWidth];
    }
    return nil;
}

/**
 * method 如果不是ntring == YES
 */
+ (BOOL)isBlankString:(NSString *)str {
    NSString *string = str;
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (string.length <= 0) {
        return YES;
    }
    
    return NO;
}

/**
 * 过滤字符串首尾的空格和回车
 */
+ (NSString *)filterTheSpaceOrEntersString:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}


+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font  maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

+ (void)notifyOtherAppToplay
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError * error = nil;
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    });
}

+(void)solveUIWidgetFuzzy:(UIView *)view
{
    CGRect frame = view.frame;
    int x = floor(frame.origin.x);
    int y = floor(frame.origin.y);
    int w = floor(frame.size.width)+1;
    int h = floor(frame.size.height)+1;
    
    view.frame = CGRectMake(x, y, w, h);
}
+ (NSString *)exportGifImages:(NSArray *)images
{
    
    
    NSString *fileName = [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"gif"];
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:filePath],
                                                                        kUTTypeGIF, images.count, NULL);
    NSDictionary *gifProperties = @{ (__bridge id)kCGImagePropertyGIFDictionary: @{
                                             (__bridge id)kCGImagePropertyGIFLoopCount: @(0), // 0 means loop forever
                                             }
                                     };
    float delay = 0.2; //默认每一帧间隔0.1秒
    for(int i= 0 ; i <images.count ;i ++){
        UIImage *itemImage = images[i];
        itemImage = [CustomTools scaleToSize:itemImage size:CGSizeMake(270, 270 * itemImage.size.height / itemImage.size.width)];
        //每一帧对应的延迟时间
        NSDictionary *frameProperties = @{(__bridge id)kCGImagePropertyGIFDictionary: @{
                                                  (__bridge id)kCGImagePropertyGIFDelayTime: @(delay), // a float (not double!) in seconds, rounded to centiseconds in the GIF data
                                                  }
                                          };
        CGImageDestinationAddImage(destination,itemImage.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"failed to finalize image destination");
    }
    CFRelease(destination);
    return filePath;
}
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time maxWidth:(CGFloat)maxWidth {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *_generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    _generator.maximumSize = CGSizeMake(maxWidth, maxWidth);
    _generator.appliesPreferredTrackTransform = YES;
    _generator.requestedTimeToleranceAfter = kCMTimeZero;
    _generator.requestedTimeToleranceBefore = kCMTimeZero;
    CMTime time1 = CMTimeMake(time * 1000, 1000);
    
    CGImageRef image = [_generator copyCGImageAtTime:time1
                                          actualTime:NULL
                                               error:nil];
    
    UIImage *picture = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    return picture;
}
+(UIImage *)compressWithImage:(UIImage *)image maxLength:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return image;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
//        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
//    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    UIImage *lastImage = [UIImage imageWithData:data];
    return lastImage;
}

#pragma mark - 获取path路径下文件夹大小
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return totleStr;
}


#pragma mark - 清除path文件夹下缓存大小
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    NSString *message  = nil;
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}
+ (NSString *)getIphoneDeviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}
+ (CGFloat)tempGetIphoneXScale
{
    if (isIPhoneXR) {
        return 828.f / 750.f;
    }else if(isIPhoneXSMax)
    {
        return 828.f / 750.f;
    }else{
        return 1;
    }
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]||[nextResponder isKindOfClass:[RDVTabBarController class]]){//1、tabBarController
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){//2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
}



+ (void)impactFeedbackGeneratorIsLight:(BOOL)isLight
{
    UIImpactFeedbackStyle feedbackStyle;
    if (isLight) {
        feedbackStyle = UIImpactFeedbackStyleMedium;
    }else{
        feedbackStyle = UIImpactFeedbackStyleHeavy;
    }
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:feedbackStyle];
    [generator prepare];
    [generator impactOccurred];
}
+ (NSString *)getDocmentPath {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
+ (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0)
    {
        return NO;
    }

    NSString *regex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:inputString];
}

+(NSString *)getDeviceIDInKeychain {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"GMU" accessGroup:nil];
    NSString *getUDIDInKeychain = (NSString *)[wrapper objectForKey:(__bridge id)(kSecValueData)];
    NSLog(@"从keychain中获取到的 UDID_INSTEAD %@",getUDIDInKeychain);
    if (!getUDIDInKeychain ||[getUDIDInKeychain isEqualToString:@""]||[getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        result = [NSString stringWithFormat:@"%@-%@",[self getTimestamp],result];
        NSLog(@"\n \n \n _____重新存储 UUID _____\n \n \n  %@",result);
        [wrapper setObject:result forKey:(__bridge id)(kSecValueData)];
        getUDIDInKeychain = result;
    }
    NSLog(@"最终 ———— UDID_INSTEAD %@",getUDIDInKeychain);
    return getUDIDInKeychain;
}
@end
