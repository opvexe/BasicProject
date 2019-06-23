//
//  CPNetworkCache.h
//  ChargingPile
//
//  Created by ZL on 16/9/5.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLSNetworkCache : NSObject
/**
 *  缓存数据
 *
 *  @param httpCache  服务器数据
 *  @param key   缓存数据库对应Key
 */
+(void)saveHttpCache:(id)httpCache  forKey:(NSString *)key;
/**
 *  获取缓存数据
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
+(id)getHttpCacheForKey:(NSString *)key ;
/**
 *  获取缓存大小
 *
 *  @return <#return value description#>
 */
+(NSInteger)getAllHttpCacheSize;
/**
 *  删除所有缓存数据
 */
+(void)removeAllHttpCache;
@end
