//
//  UIAlertController+WHBlocks.m
//  WasteHouse
//
//  Created by snowlu on 2018/5/12.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "UIAlertController+WHBlocks.h"

@implementation UIAlertController (WHBlocks)

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message enterTitle:(NSString *)enterTitle cancelButtonTitle:(NSString *)cancelButtonTitle clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (enterTitle && ![enterTitle isEqualToString:@""]) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:enterTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlcok) {
                alertBlcok(action);
            }
        }];
        [alertVC addAction:confirmAction];
    }
    
    if (cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlcok) {
                alertBlcok(action);
            }
        }];
        [alertVC addAction:cancelAction];
    }
    return alertVC;
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                                  message:(NSString *)message
                              cancelTitle:(NSString *)cancelTitle
                              commitTitle:(NSString *)commitTitle
                              cancelColor:(UIColor *)cancelColor
                              commitColor:(UIColor *)commitColor
                         clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (!is_null(cancelTitle)) {
        UIAlertAction *continueAc = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !alertBlcok ?: alertBlcok(action);
        }];
        
        [alertController addAction:continueAc];
        if (cancelColor) {
            [continueAc setValue:cancelColor forKey:@"_titleTextColor"];
        }
    }
    
    
    if (!is_null(commitTitle)) {
        UIAlertAction *commitAc = [UIAlertAction actionWithTitle:commitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !alertBlcok ?: alertBlcok(action);
        }];
        
        [alertController addAction:commitAc];
        if (commitColor) {
            [commitAc setValue:commitColor forKey:@"_titleTextColor"];
        }
    }
    
    return alertController;
}

+ (UIAlertController *)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickButtonBlock:(UIAlertControllerClickBlock)alertBlcok {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlcok) {
                alertBlcok(action);
            }
        }];
        [alertVC addAction:cancelAction];
    }
    
    if (destructiveButtonTitle && ![destructiveButtonTitle isEqualToString:@""]) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlcok) {
                alertBlcok(action);
            }
        }];
        [alertVC addAction:destructiveAction];
    }
    
    for (NSString *otherTitle in otherButtonTitles) {
        if (otherTitle && ![otherTitle isEqualToString:@""]) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertBlcok) {
                    alertBlcok(action);
                }
            }];
            [alertVC addAction:otherAction];
        }
    }
    return alertVC;
}
@end
