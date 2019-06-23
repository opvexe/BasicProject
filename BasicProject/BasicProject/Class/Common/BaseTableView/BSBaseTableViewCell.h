//
//  BSBaseTableViewCell.h
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBaseTableViewCellProtocol.h"
@interface BSBaseTableViewCell : UITableViewCell<BSBaseTableViewCellProtocol>

@property(nonatomic,strong)UIView *bottomlineView;

+(id)cellWithTableView:(UITableView *)tableview;

@end
