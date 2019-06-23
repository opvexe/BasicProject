//
//  BSBaseTableHeaderFooterView.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseTableHeaderFooterView.h"

@interface BSBaseTableHeaderFooterView()
@property(nonatomic,strong)UIView *footerLineView;
@end

@implementation BSBaseTableHeaderFooterView

+(instancetype )headViewWithTableView:(UITableView *)tableview{
    
    return nil;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
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
    
    _footerLineView = ({
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
