//
//  BSBaseViewController.m
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseViewController.h"
#import "BSTabBarControllerConfig.h"
#import "AppDelegate.h"
#import "BSBaseNavigationController.h"
@interface BSBaseViewController ()

@end

@implementation BSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BaseViewControllerColor;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:NSStringFromSelector(_cmd)];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MobClick event:NSStringFromSelector(_cmd)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///MARK: 切换登录
-(void)switchRootController{
    BSTabBarControllerConfig  *tabBarControllerConfig = [BSTabBarControllerConfig new];
    AppDelegate  *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = tabBarControllerConfig.tabBarController;
}
//退出
-(void)loginOut{

    
}

-(void)dealloc{
    [MobClick event:NSStringFromSelector(_cmd)];
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
