//
//  BSBaseTableViewCell.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseTableViewCell.h"

@interface BSBaseTableViewCell ()

@end

@implementation BSBaseTableViewCell

+(id)cellWithTableView:(UITableView *)tableview{
    
    return nil;
};

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [self BSSinitConfingViews];
    
    }
    return  self ;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self BSSinitConfingViews];
}

/**
 *  初始视图
 */
- (void)BSSinitConfingViews{
    
    _bottomlineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = lineBackgroundColor;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
    
}

-(void)InitDataWithModel:(BSBaseModel *)model{
    
}


+(CGFloat)getCellHeight:(BSBaseModel *)model{
    return 0;
}
-(void)dealloc{
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
