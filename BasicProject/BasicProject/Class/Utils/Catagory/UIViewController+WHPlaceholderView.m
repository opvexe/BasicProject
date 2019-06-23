//
//  UIViewController+WHPlaceholderView.m
//  WasteHouse
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "UIViewController+WHPlaceholderView.h"
#import <objc/runtime.h>
#import "UIView+Toast.h"
@implementation UIViewController (WHPlaceholderView)

-(void)setPlaceholderView:(UIView *)placeholderView{
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)placeholderView{
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark  刷新
-(void)reloadDataSoucre{
    
    
}

-(void)networkErrorWithView:(UIView*)view  target:(id)target action:(SEL)action {
    [self createPlaceholderView:nil message:@"您的网络罢工了\n尝试 点击刷新" image:[UIImage imageNamed:@"network"] withView:view action:YES target:target action:action];
}
-(void)networkErrorWithView:(UIView*)view  {
    [self createPlaceholderView:nil message:@"您的网络罢工了\n尝试 点击刷新" image:[UIImage imageNamed:@"network"] withView:view action:YES];
}
#pragma mark
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createPlaceholderView:title message:message image:image withView:superView action:NO ];
    });
}
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(BOOL)reloadAction {
    [self createPlaceholderView:title message:message image:image withView:superView action:reloadAction target:nil action:nil];
}

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView  target:(id)target action:(SEL)action{
    [self createPlaceholderView:title message:message image:image withView:superView action:YES target:target action:action];
}
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(BOOL)reloadAction  target:(id)target action:(SEL)action {
    
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    self.placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, superView.bounds.size.width, superView.bounds.size.height)];
    [self.placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.placeholderView setAutoresizesSubviews:YES];
    [self.placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:self.placeholderView];
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]init];
    if(image){
        [icon setImage:image];
    }
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [self.placeholderView addSubview:icon];
    CGFloat y = icon.frame.size.height+25;
    if(message){
        NSMutableAttributedString*messageText= [[NSMutableAttributedString alloc] initWithString:message];
        messageText.font = FontPingFangLG(14);
        messageText.alignment = NSTextAlignmentCenter;
        messageText.lineSpacing = 8;
        messageText.color =[UIColor colorWithHexString:@"9EA0AF"];
        CGSize introSize = CGSizeMake(kScreenWidth, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:messageText];
        CGFloat height= layout.textBoundingSize.height;
        YYLabel *lblTitle=[[YYLabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width,height)];
        lblTitle.numberOfLines = 0 ;
        lblTitle .textLayout = layout;
        [self.placeholderView addSubview:lblTitle];
        y=y+height + 5;
        if(reloadAction){
            NSRange  range = [message rangeOfString:@"点击刷新"];
            [messageText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
            @weakify(self);
            __weak typeof(target) weakSelfTarget = target;
            [messageText setTextHighlightRange:range color:[UIColor colorWithHexString:@"4a4a4a"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                @strongify(self);
                __strong typeof(weakSelfTarget) strongWeakTarget= weakSelfTarget;
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if (target) {
                    [(strongWeakTarget) performSelector:action withObject:nil];
                }else{
                    [self reloadDataSoucre];
                }
#pragma clang diagnostic pop
            }];
        }
        lblTitle.attributedText = messageText;
    }
    pf.size.height= y;
    [self.placeholderView setFrame:pf];
    [self.placeholderView setCenter:CGPointMake(superView.width * 0.5 , superView.height * 0.5)];
}
- (void)removePlaceholderView{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.placeholderView && self.placeholderView!=nil) {
            [self.placeholderView removeFromSuperview];
            self.placeholderView = nil;
        }
    });
}

- (void)makeToast:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter];
    });
    
}
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType)position
{
    NSString *positionType =@"CSToastPositionTop";
    switch (position) {
        case ToastPositionTypeTop:
            positionType =@"CSToastPositionTop";
            break;
        case ToastPositionTypeBottom:
            positionType =@"CSToastPositionBottom";
            break;
        case ToastPositionTypeCenter:
            positionType =@"CSToastPositionCenter";
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToast:message duration:duration position:positionType];
    });
}
-(void)makeToast:(NSString *)message backImageView:(NSString *)image {

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter title:nil image:[UIImage imageNamed:image] style:nil completion:nil];
    });
    
    
}
@end
