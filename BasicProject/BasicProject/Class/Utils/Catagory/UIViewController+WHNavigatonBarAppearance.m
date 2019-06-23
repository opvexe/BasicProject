//
//  UIViewController+WHNavigatonBarAppearance.m
//  WasteHouse
//
//  Created by snowlu on 2018/5/19.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "UIViewController+WHNavigatonBarAppearance.h"

@implementation UIViewController (WHNavigatonBarAppearance)

- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass
{
    UIViewController *bvc = [[viewControllerClass alloc] init];
    if (bvc) {
        [self.navigationController pushViewController:bvc animated:YES
         ];
    }
}

- (void)addPopBackBarButtonItem {
	
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
	
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
	
	leftBtn.frame = CGRectMake(0, 0,25, 25);
	
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[leftBtnItem];
}

-(void)popBack{
    
    if(self.navigationController!=nil){
        if (self.navigationController.childViewControllers.count ==1) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        return;
        
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (UIBarButtonItem *)backBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *colorView = [UIButton buttonWithType:UIButtonTypeCustom];
    [colorView setFrame:CGRectMake(0, 0, 25, 25)];
    
    UIImageView *image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_icon_back"]];
    [colorView addSubview:image_view];
    [image_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(colorView);
        make.centerY.equalTo(colorView);
        make.size.mas_equalTo(CGSizeMake(15, 25));
    }];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font =FontPingFangSC(14);
    [label sizeToFit];
    [colorView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image_view.mas_right);
        make.centerY.equalTo(colorView);
    }];
    [colorView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_left =[[UIBarButtonItem alloc] initWithCustomView:colorView];
    return btn_left;
}

- (UIBarButtonItem *)leftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [self getWidthWithContent:title height:25 UIFont:FontPingFangSC(14)];
    [button setFrame:CGRectMake(0, 0, width, 25)];
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font =FontPingFangSC(14);
	
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedButton.width = -15;
    self.navigationItem.leftBarButtonItems = @[fixedButton, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25 - image.size.width);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedButton.width = -15;
    self.navigationItem.leftBarButtonItems = @[fixedButton, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    
    return [self rightBarButtonWithTitle:title titleColor:titleColor font:FontPingFangSC(15) target:target action:action];
}

- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [self getWidthWithContent:title height:25 UIFont:FontPingFangSC(15)];
    [button setFrame:CGRectMake(0, 0, width + 4, 25)];
	
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    
    return barButtonItem;
}


- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 5, 25)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithView:(UIView *)view
{
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UILabel *)navTitleLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont mediumFontOfSize:18];
    label.text = title;
    label.textColor = MainColor;
    [label sizeToFit];
    self.navigationItem.titleView = label;
    return label;
}
//根据高度度求宽度  content 计算的内容  Height 计算的高度 font字体
- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height UIFont:(UIFont *)font {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size.width;
    
}

@end
