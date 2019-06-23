//
//  BSPlusButtonSubclass.m
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSPlusButtonSubclass.h"
#import "CYLTabBarController.h"
#import "BSBaseNavigationController.h"

@implementation BSPlusButtonSubclass

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

+ (id)plusButton {
    BSPlusButtonSubclass *button = [[BSPlusButtonSubclass alloc]init];
    UIImage *buttonImage = [UIImage imageNamed:@"push_normal"];
    UIImage *buttonImageSeleted = [UIImage imageNamed:@"push_selected"];
    [button setImage:buttonImage  forState:UIControlStateNormal];
    [button setImage:buttonImageSeleted  forState:UIControlStateSelected];
    [button addTarget:button action:@selector(clickPublish:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return button;
}

#pragma mark - Event Response

- (void)clickPublish:(UIButton *)sender {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;    
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    //    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    //    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    CGFloat const imageViewEdgeWidth   = 64;
    CGFloat const imageViewEdgeHeight  = 49;
    
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat  verticalMargin  = 0;
    if (BSiPhoneX) {
        verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight)*0.8;
    }
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

@end
