//
//  WHHudView.h
//  WasteHouse
//
//  Created by snowlu on 2018/6/28.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHHudView : UIView

+ (void)show;

+ (void)hide;

+ (void)hideAfterDelay;

+ (void)showMessage:(NSString *)text;

@end
