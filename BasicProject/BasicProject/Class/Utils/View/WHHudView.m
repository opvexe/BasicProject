
//
//  WHHudView.m
//  WasteHouse
//
//  Created by snowlu on 2018/6/28.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "WHHudView.h"
#import <MBProgressHUD.h>

@interface WHLoadingView : UIView

@end

@implementation WHLoadingView


- (instancetype)initWithTitleLabel:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = title;
        label.font = FontNormal(14);
        label.textColor = UIColorFromRGB(0X333333);
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
        }];
        CGSize labelSize = [label intrinsicContentSize];
        CGFloat viewWidth = labelSize.width + 60 > (SCREEN_WIDTH - 100) ?  (SCREEN_WIDTH - 100) : (labelSize.width + 60);
        self.frame = CGRectMake(0, 0, viewWidth, labelSize.height + 40);
    }
    return self;
}
@end

@interface WHHudView ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end


@implementation WHHudView

+ (WHHudView *)sharedHUD {
    static WHHudView *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[WHHudView alloc] init];
    });
    return hud;
}

+ (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hudView = [MBProgressHUD HUDForView:window];
    if (hudView) {
        if (!hudView.customView) {
            [hudView hideAnimated:NO];
        }
    }
    [MBProgressHUD showHUDAddedTo:window animated:YES];
}

+ (void)hide {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

+ (void)showMessage:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    WHLoadingView *loadingView = [[WHLoadingView alloc] initWithTitleLabel:text];
    hud.customView = loadingView;
    hud.margin = 0;
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)hideAfterDelay {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

@end
