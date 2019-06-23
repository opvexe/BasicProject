//
//  UIGestureRecognizer+WHExtension.h
//  WasteHouse
//
//  Created by snowlu on 2018/4/22.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (WHExtension)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;


- (void)addActionBlock:(void (^)(id sender))block;


- (void)removeAllActionBlocks;

@end
NS_ASSUME_NONNULL_END
