//
//  BSBaseView.m
//  BellService
//
//  Created by snowlu on 2018/9/24.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseView.h"

@implementation BSBaseView
-(instancetype)init{
    
    if (self = [super init]) {
        
        [self BSGetDataSoucre];
        [self BSSInitConfingViews];
    }
    return  self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self BSGetDataSoucre];
    [self BSSInitConfingViews];
    
}

-(void)BSGetDataSoucre{
    
}

- (void)BSSInitConfingViews{
    
}

-(void)dealloc{
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}
@end
