//
//  CPNetworkCache.m
//  ChargingPile
//
//  Created by ZL on 16/9/5.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import "BSLSNetworkCache.h"
#import "YYCache.h"
static NSString *const WYNetworkResponseCache = @"WYNetworkResponseCache";
static YYCache *_dataCache;
@implementation BSLSNetworkCache
+(void)initialize{

    _dataCache = [YYCache cacheWithName:WYNetworkResponseCache];
}
+(void)saveHttpCache:(id)httpCache forKey:(NSString *)key{


    [_dataCache setObject:httpCache forKey:key withBlock:nil];
}
+(id)getHttpCacheForKey:(NSString *)key{


    return  [_dataCache objectForKey:key];

}
+(NSInteger)getAllHttpCacheSize{

    return  [_dataCache.diskCache totalCost];
}
+(void)removeAllHttpCache{

    [_dataCache.diskCache removeAllObjects];

}
@end
