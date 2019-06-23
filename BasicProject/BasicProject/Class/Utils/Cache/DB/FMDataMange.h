//
//  FMDataMange.h
//  TestDemo
//
//  Created by ZL on 15/11/29.
//  Copyright © 2015年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
typedef void(^DBMangeBlock)(FMDatabase *_db);

@interface FMDataMange : NSObject
/**
 *  初始化
 *
 *  @return
 */
+(instancetype)shareFMDataMange;
/**
 *  创建数据库
 *
 *  @param isAsynch 是否异步
 *  @param block    
 */
-(void)creatDBMange:(BOOL )isAsynch dbBlock:( DBMangeBlock )block;

-(void)clearDB;
@end
