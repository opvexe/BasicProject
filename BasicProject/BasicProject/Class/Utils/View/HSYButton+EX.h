//
//  HSYButton+EX.h
//  SuperstarUser
//
//  Created by snowlu on 2017/10/18.
//  Copyright © 2017年 HSY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonDisplayType) {
    ButtonDisplayTypeNone,
    ButtonDisplayTypeImageLeftTileRight,
    ButtonDisplayTypeImageUpTileDown,
     ButtonDisplayTypeImageUpTile,
};
IB_DESIGNABLE
@interface HSYButton_EX : UIButton
@property(nonatomic,assign)IBInspectable ButtonDisplayType type;
@end
