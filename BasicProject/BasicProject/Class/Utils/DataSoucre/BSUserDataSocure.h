//
//  BSUserDataSocure.h
//  BellService
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLoginModel.h"
@interface BSUserDataSocure : NSObject

+ (BSUserDataSocure *)shareInstance;
/**
 *  更新用户信息
 *
 *  @param userInfo 用户信息 \
 */
-(void)updateUserInfor:(id)userInfo;

-(BSLoginModel *)getInstance;

-(void)clearUserInfor;
@end
