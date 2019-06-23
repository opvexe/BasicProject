//
//  BSTabBarControllerConfig.m
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSTabBarControllerConfig.h"
#import "BSRootViewController.h"
#import "BSMessageViewController.h"
#import "BSMineViewController.h"
#import "BSBaseNavigationController.h"
@interface BSTabBarControllerConfig ()<CYLTabBarControllerDelegate>
@property (nonatomic, strong) CYLTabBarController *tabBarController;
@end


@implementation BSTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        
        BSRootViewController *tabBarController = [BSRootViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:UIEdgeInsetsMake(4.5, 0, -4.5, 0) titlePositionAdjustment:UIOffsetZero];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}
- (NSArray *)viewControllers {
    

    
    BSMessageViewController *messageViewController = [[BSMessageViewController alloc] init];
    UIViewController *messageNavigationController = [[BSBaseNavigationController alloc]
                                                     initWithRootViewController:messageViewController];
    
    BSMineViewController *mineViewController = [[BSMineViewController alloc] init];
    UIViewController *mineNavigationController = [[BSBaseNavigationController alloc]
                                                  initWithRootViewController:mineViewController];
    
    
    
    NSArray *viewControllers = @[
                                 messageNavigationController,
                                 mineNavigationController];
    return viewControllers;
}
- (NSArray *)tabBarItemsAttributesForController {

    
    NSDictionary *messageTabBarItemsAttributes = @{
                                                   CYLTabBarItemImage : @"message_noarmal",
                                                   CYLTabBarItemSelectedImage : @"message_selected",
                                                   };
    
    NSDictionary *mineTabBarItemsAttributes = @{
                                                CYLTabBarItemImage : @"mine_normal",
                                                CYLTabBarItemSelectedImage : @"mine_selected",
                                                };
    NSArray *tabBarItemsAttributes = @[
                                       messageTabBarItemsAttributes,
                                       mineTabBarItemsAttributes];
    return tabBarItemsAttributes;
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
