//
//  AppDelegate+BSExtension.m
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "AppDelegate+BSExtension.h"
#import "BSPlusButtonSubclass.h"
#import "BSTabBarControllerConfig.h"
#import "BSBaseNavigationController.h"
@implementation AppDelegate (BSExtension)

-(void)switchRootController{
        [BSPlusButtonSubclass registerPlusButton];
        BSTabBarControllerConfig  *tabBarControllerConfig = [BSTabBarControllerConfig new];
        self.window.rootViewController = tabBarControllerConfig.tabBarController;
}

- (void)configUSharePlatforms
{
//    [UMConfigure initWithAppkey:UMAPPKEY channel:@"APP Store"];
    [UMConfigure setLogEnabled:true];

    [Bugly startWithAppId:@"11f15d2e08"];
    
}
-(void)initThirdLib{
    [self configUSharePlatforms];
}
-(void)switchMainController{
    
    BSTabBarControllerConfig  *tabBarControllerConfig = [BSTabBarControllerConfig new];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    
    //    //    DLog(@"url = %@ \n options = %@",url,options);
    //    if ([url.host isEqualToString:@"safepay"]) {
    //        //跳转支付宝钱包进行支付，处理支付结果
    //        return YES;
    //    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"pay"]) {
    //        return YES;
    //    }else{
    //        return [[UMSocialManager defaultManager] handleOpenURL:url];
    //    }
    //
    //
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
