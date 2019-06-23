//
//  BSBaseTableViewCellProtocol.h
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//
#import <Foundation/Foundation.h>

@class BSBaseModel;
@protocol BSBaseTableViewCellProtocol <NSObject>

@optional
/**
 *  初始视图
 */
- (void)BSSinitConfingViews;

-(void)InitDataWithModel:(BSBaseModel *)model;


+(CGFloat)getCellHeight:(BSBaseModel *)model;

@end
