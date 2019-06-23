//
//  CPNetworkHelper.h
//  ChargingPile
//
//  Created by ZL on 16/9/5.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLSNetworkCache.h"
#define  HttpTimeOut  30.0f

typedef NS_ENUM(NSUInteger, CPNetworkStatus) {
    /** 未知网络*/
    CPNetworkStatusUnknown,
    /** 无网络*/
    CPNetworkStatusNotReachable,
    /** 手机网络2G*/
     CPNetworkStatusReachableVia2G,
    /** 手机网络3G*/
     CPNetworkStatusReachableVia3G,
     /** 手机网络4G*/
     CPNetworkStatusReachableVia4G,
    /** WIFI网络*/
    CPNetworkStatusReachableViaWiFi,
    
    CPNetworkStatusReachableViaReachableViaWWAN,
};
/**
 *  请求成功
 *
 *  @param responseObject
 */
typedef void(^CPNetworkRequestSuccess)(id responseObject);
/**
 *  请求失败
 *
 *  @param error
 */
typedef void(^CPNetworkRequestFailed)(NSError *error);
/**
 *  缓存数据
 *
 *  @param responseCache
 */
typedef void(^CPNetworkRequestCache)(id responseCache);
/**
 *  进度
 *
 *  @param progress <#progress description#>
 */
typedef void(^CPNetworkProgress)(NSProgress *progress);
/**
 *  网络状态
 *
 *  @param status
 */
typedef void(^NetworkReachabilityStatus)(CPNetworkStatus status);
/**
 *  响应类型
 */
typedef NS_ENUM(NSUInteger, CPNetworkResponseType) {

    CPNetworkResponseTypeJSON = 1,
    /**
     *  <#Description#>
     */
    CPNetworkResponseTypeXML  = 2,
    /**
     *  <#Description#>
     *
     XML / 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换*/
    CPNetworkResponseTypeData = 3
};
/**
 *  请求类型
 */
typedef NS_ENUM(NSUInteger, CPNetworkRequestType) {
    /**
     *
     */
    CPNetworkRequestTypeJSON = 1,
    /**
     *   普通text/html
     */
    CPNetworkRequestTypePlainText = 2
};

@interface BSLSNetworkHelper : NSObject
/**
 *  监听网络
 */
+ (void)startListeningNetwork;
/**
 *  获取网络状态
 *
 *  @param status
 */
+ (void)checkNetworkStatusWithBlock:(NetworkReachabilityStatus)status;
/**
 *  
 */

+(NSString *)currentNetworkTypeStatus;


+ (BOOL)currentNetworkStatus;
/**
 *  公共
 *
 *  @param httpHeaders <#httpHeaders description#>
 */
+(void)configPublicHttpHeaders:(NSDictionary *)httpHeaders;
/**
 *  是编码
 *
 *  @param shouldAutoEncode <#shouldAutoEncode description#>
 */
+(void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;
/**
 *  请求类型  default  CPNetworkRequestTypePlainText

 *  @param requestType <#requestType description#>
 */
+(void)configRequestType:(CPNetworkRequestType)requestType;
/**
 *  响应类型  default  CPNetworkRequestTypePlainText
 *
 *  @param responseType CPNetworkResponseTypeJSON
 */
+(void)configResponseType:(CPNetworkResponseType)responseType;
/**
 *  取消所有请求
 */
+(void)cancleAllRequest;
/**
 *  通过URL取消请求
 *
 *  @param url <#url description#>
 */
+ (void)cancelRequestWithURL:(NSString *)url;
/**
 *  <#Description#>
 *
 *  @param URL           <#URL description#>
 *  @param parameters    <#parameters description#>
 *  @param responseCache <#responseCache description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(CPNetworkRequestCache)responseCache
                  success:(CPNetworkRequestSuccess)success
                  failure:(CPNetworkRequestFailed)failure;
/**
 *  <#Description#>
 *
 *  @param URL           <#URL description#>
 *  @param parameters    <#parameters description#>
 *  @param headDic       <#headDic description#>
 *  @param responseCache <#responseCache description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
            responseCache:(CPNetworkRequestCache)responseCache
                  success:(CPNetworkRequestSuccess)success
                  failure:(CPNetworkRequestFailed)failure;
/**
 *
 *
 *  @param URL        <#URL description#>
 *  @param parameters <#parameters description#>
 *  @param headDic    <#headDic description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                  success:(CPNetworkRequestSuccess)success
                  failure:(CPNetworkRequestFailed)failure;
/**
 *  GET 请求
 *
 *  @param URL        <#URL description#>
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(CPNetworkRequestSuccess)success
                  failure:(CPNetworkRequestFailed)failure;
/**
 *  <#Description#>
 *
 *  @param URL           <#URL description#>
 *  @param parameters    <#parameters description#>
 *  @param responseCache <#responseCache description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(CPNetworkRequestCache)responseCache
                   success:(CPNetworkRequestSuccess)success
                   failure:(CPNetworkRequestFailed)failure;
/**
 *  <#Description#>
 *
 *  @param URL           <#URL description#>
 *  @param parameters    <#parameters description#>
 *  @param headDic       <#headDic description#>
 *  @param responseCache <#responseCache description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
             responseCache:(CPNetworkRequestCache)responseCache
                   success:(CPNetworkRequestSuccess)success
                   failure:(CPNetworkRequestFailed)failure;
/**
 *
 *
 *  @param URL        <#URL description#>
 *  @param parameters <#parameters description#>
 *  @param headDic    <#headDic description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                   success:(CPNetworkRequestSuccess)success
                   failure:(CPNetworkRequestFailed)failure;
/**
 *
 *
 *  @param URL        <#URL description#>
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(CPNetworkRequestSuccess)success
                   failure:(CPNetworkRequestFailed)failure;
/**
 *  上传 图片
 *
 *  @param URL        <#URL description#>
 *  @param parameters <#parameters description#>
 *  @param images     <#images description#>
 *  @param name       <#name description#>
 *  @param fileName   <#fileName description#>
 *  @param mimeType   <#mimeType description#>
 *  @param progress   <#progress description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                                 images:(NSArray<UIImage *> *)images
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                               progress:(CPNetworkProgress)progress
                                success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure;
/**
 *    上传视频
 *
 *  @param parameters
 *  @param videoPath  <#videoPath description#>
 *  @param URL        <#URL description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *  @param progress   <#progress description#>
 */
+(void)uploadVideoWithParameters:(NSDictionary *)parameters withVideoPath:(NSString *)videoPath withURL:(NSString *)URL withSuccess:(CPNetworkRequestSuccess)success withFailure:(CPNetworkRequestFailed)failure withProgress:(CPNetworkProgress)progress;


+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                                 images:(NSArray<UIImage *> *)images
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                               progress:(CPNetworkProgress)progress
                                success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure;
/**
 *  多文件上传
 *
 *  @param parameters <#parameters description#>
 *  @param videoPath  <#videoPath description#>
 *  @param URL        <#URL description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *  @param progress   <#progress description#>
 */
+ (NSArray *)uploadMultFileWithURL:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                         fileDatas:(NSArray *)dataSoucre
                              type:(NSString *)type
                              name:(NSString *)name
                          mimeType:(NSString *)mimeTypes
                          Progress:(CPNetworkProgress)progress
                           Success:(CPNetworkRequestSuccess)success
                           failure:(CPNetworkRequestFailed)failure;
/**
 *  下载
 *
 *  @param URL      <#URL description#>
 *  @param fileDir  <#fileDir description#>
 *  @param progress <#progress description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 *
 *  @return <#return value description#>
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(CPNetworkProgress)progress
                              success:(void(^)(NSURLResponse * _Nonnull response,  NSString * _Nullable filePath))success
                              failure:(CPNetworkRequestFailed)failure;

@end
