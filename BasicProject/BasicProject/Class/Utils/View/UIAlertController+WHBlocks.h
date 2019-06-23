//
//  UIAlertController+WHBlocks.h
//  WasteHouse
//
//  Created by snowlu on 2018/5/12.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ACDismissBlock)();
typedef void(^ACCancelBlock)();
typedef void(^ACOtherBlock)(UIAlertAction *action);

typedef UIAlertAction SYAlertAction;

typedef void(^UIAlertControllerClickBlock)(UIAlertAction *action);

@interface UIAlertController (WHBlocks)
+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message enterTitle:(NSString *)enterTitle cancelButtonTitle:(NSString *)cancelButtonTitle clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok;

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                              cancelTitle:(NSString *)cancelTitle
                              commitTitle:(NSString *)commitTitle
                              cancelColor:(UIColor *)cancelColor
                              commitColor:(UIColor *)commitColor
                         clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok;


+ (UIAlertController *)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok;
@end
