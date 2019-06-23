//
//  BSBaseCollectionReusableView.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseCollectionReusableView.h"

@implementation BSBaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self BSSinitConfingViews];
        
    }
    return  self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self BSSinitConfingViews];
    
}
/**
 *  初始视图
 */
- (void)WDSinitConfingViews{
    
}

-(void)InitDataWithModel:(BSBaseModel *)model{
    
}

+(CGSize)getHeight:(BSBaseModel* )model{
    
    return CGSizeZero;
}

-(void)dealloc{
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
