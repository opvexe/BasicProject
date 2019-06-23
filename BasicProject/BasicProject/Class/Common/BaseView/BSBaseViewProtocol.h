//
//  BSBaseViewProtocol.h
//  BellService
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 BellService. All rights reserved.
//
@class BSBaseModel;
@protocol BSBaseViewProtocol <NSObject>
@optional
/**
 *  获取数据
 */
-(void)BSGetDataSoucre;
/**
 *  初始视图
 */
- (void)BSSInitConfingViews;

-(void)InitDataWithModel:(BSBaseModel *)model;

@end;

