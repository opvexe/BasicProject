//
//  FMDataMange.m
//  TestDemo
//
//  Created by ZL on 15/11/29.
//  Copyright © 2015年 ZL. All rights reserved.
//
#define FileName @"DB"
#define DBNAME    @"WastHouse2.db"
#import "FMDataMange.h"

@implementation FMDataMange
{
    NSString *database_path;
    FMDatabase *_db;
    FMDatabaseQueue *_dbQueue;
}
+(instancetype)shareFMDataMange
{
    static FMDataMange *_mange=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mange = [[FMDataMange alloc] init];
    });
    return _mange;
}
-(instancetype)init
{
    self= [super init];
    
    if (self) {
        
        NSString *path = getDocumentsFilePath(FileName);
        
        checkPathAndCreate(path);
        
        database_path = [NSString stringWithFormat:@"%@/%@-%@",path,AppVersion,DBNAME];
        
        _db = [FMDatabase databaseWithPath:database_path];
        
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:database_path];

        NSLog(@"database_path:数据库地址:%@",database_path);
        
    }
    return self;
    
}
-(void)creatDBMange:(BOOL)isAsynch dbBlock:(DBMangeBlock )block
{
    
    if (isAsynch) {
        
        dispatch_queue_t q= dispatch_queue_create("WithMusicQueue.db", DISPATCH_QUEUE_CONCURRENT);
        
        //异步请求数据库
        
        dispatch_async(q, ^{
            
            [_dbQueue inDatabase:^(FMDatabase *db) {
                
                block(db);
            }];
        });
        
    }else {
        
        if ([_db open]) {
            
            block (_db);
            
            [_db close];
        }
        
    }
    
}

-(BOOL)savaModel:(NSString *)sql isSynch:(BOOL)isSynchronous{
    
    if (isSynchronous) {
        
        dispatch_queue_t q = dispatch_queue_create("WasteHouseQueue.db", DISPATCH_QUEUE_CONCURRENT  );
        //异步请求数据库
        
        dispatch_async(q, ^{
            [_dbQueue inDatabase:^(FMDatabase *db) {
                
                [db executeUpdate:sql];
            }];
        });
    }
    return YES;
}

-(void)clearDB{
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:database_path error:nil];
}
@end
