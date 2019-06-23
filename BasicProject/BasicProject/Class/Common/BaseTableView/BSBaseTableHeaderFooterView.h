//
//  BSBaseTableHeaderFooterView.h
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBaseTabelHeaderFooterViewProtocol.h"
@interface BSBaseTableHeaderFooterView : UITableViewHeaderFooterView<BaseTabelHeaderFooterViewProtocol>
+(instancetype )headViewWithTableView:(UITableView *)tableview;
@end
