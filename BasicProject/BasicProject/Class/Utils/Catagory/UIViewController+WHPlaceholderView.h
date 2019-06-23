//
//  UIViewController+WHPlaceholderView.h
//  WasteHouse
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ToastPositionType) {
    ToastPositionTypeTop,
    ToastPositionTypeCenter,
    ToastPositionTypeBottom,
};


@interface UIViewController (WHPlaceholderView)

@property(nonatomic,strong)UIView *placeholderView;

/**
 网络失败 显示 视图
 
 @param view view description
 @param target target description
 @param action action description
 */
-(void)networkErrorWithView:(UIView*)view  target:(id)target action:(SEL)action;
/**
 *  网络失败 显示 视图
 */
-(void)networkErrorWithView:(UIView*)view ;
/**
 *  刷 新数据
 */
-(void)reloadDataSoucre;
#pragma mark 占位图

/**
 自定义方法
 
 @param title <#title description#>
 @param message <#message description#>
 @param image <#image description#>
 @param superView <#superView description#>
 @param target <#target description#>
 @param action <#action description#>
 */
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView  target:(id)target action:(SEL)action;
/**
 *  Description
 *
 *  @param title     title description
 *  @param message   message description
 *  @param image     image description
 *  @param superView superView description
 */
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView;
/**
 *  Description
 *  刷新方法  reloadDataSoucre
 *  @param title        title description
 *  @param message      message description
 *  @param image        image description
 *  @param superView    superView description
 *  @param reloadAction reloadAction description
 */
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(BOOL)reloadAction;
/**
 *  删除占位图
 */
- (void)removePlaceholderView;

- (void)makeToast:(NSString *)message;

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType )position;

-(void)makeToast:(NSString *)message backImageView:(NSString *)image;
@end
