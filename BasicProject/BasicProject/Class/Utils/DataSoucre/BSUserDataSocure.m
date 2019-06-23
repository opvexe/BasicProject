//
//  BSUserDataSocure.m
//  BellService
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSUserDataSocure.h"

#define BSLoginUser @"BSLoginUser"

@implementation BSUserDataSocure
+ (BSUserDataSocure *)shareInstance{
    static BSUserDataSocure *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}
/**
 *  更新用户信息
 *
 *  @param userInfo 用户信息 json
 */
-(void)updateUserInfor:(id)userInfo{
    @try {
        if (!is_null(userInfo)&&[userInfo isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionaryWithCapacity:0];
            NSDictionary *userInfoTemp  =(NSDictionary *) userInfo;
            for (NSString *key in userInfoTemp.allKeys) {
                [newUserInfo setValue:convertToString([userInfoTemp valueForKey:key]) forKey:key];
            }
            [BSWMUserDefaults setValue:newUserInfo forKey:BSLoginUser];
            [BSWMUserDefaults synchronize];
        } else if(!is_null(userInfo)&&[userInfo isKindOfClass:[BSBaseModel class]]) {
            NSDictionary *tempUserinfo = [(BSBaseModel *)userInfo mj_keyValues];
            NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionaryWithCapacity:0];
            for (NSString *key in tempUserinfo.allKeys) {
                [newUserInfo setValue:convertToString([tempUserinfo valueForKey:key]) forKey:key];
            }
            [BSWMUserDefaults setValue:newUserInfo forKey:BSLoginUser];
            [BSWMUserDefaults synchronize];
            
        }else{
            NSLog(@"这种情况怎么没处理。");
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        NSLog(@"这种情况怎么没处理。");
    }
}
/**
 *  获取本地用户信息
 *
 *  @return return 用户信息
 */
-(BSLoginModel *)getInstance{
    return [BSLoginModel mj_objectWithKeyValues:[BSWMUserDefaults valueForKey:BSLoginUser]];
}
/**
 *  清除信息
 *
 */
-(void)clearUserInfor{
    [BSWMUserDefaults removeObjectForKey:BSLoginUser];
    [BSWMUserDefaults synchronize];
}
@end
