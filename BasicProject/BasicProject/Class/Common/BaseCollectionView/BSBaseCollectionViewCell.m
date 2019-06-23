//
//  BSBaseCollectionViewCell.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseCollectionViewCell.h"

@implementation BSBaseCollectionViewCell
+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    BSBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BSBaseCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        [self BSSinitConfingViews];
        

    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self BSSinitConfingViews];

}
/**
 *  初始视图
 */
- (void)BSSinitConfingViews{
    
    
    
}

/**
 *
 *
 *  @param model <#model description#>
 */
-(void)InitDataWithModel:(BSBaseModel *)model{
    
    
}

+(CGSize)getCellHeight:(BSBaseModel *)model{
    
    return CGSizeZero;
    
}
-(void)dealloc{
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
