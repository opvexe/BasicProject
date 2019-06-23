//
//  BSBaseTableView.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseTableView.h"


@interface BSBaseTableView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation BSBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.estimatedRowHeight = 0;
            self.estimatedSectionFooterHeight = 0.1f;
            self.estimatedSectionHeaderHeight = 0.1f;
            self.tableFooterView  =[UIView new];
    }
    return self;
}

- (void)setMJRefreshHeaderFooter {
    @weakify(self);
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self headerWithRefreshing];
    }];
    // 设置字体
    if ([self.mj_header isKindOfClass:[MJRefreshNormalHeader class]]) {
        MJRefreshNormalHeader * refreshNormalHeader =  (MJRefreshNormalHeader*)self.mj_header;
        refreshNormalHeader.stateLabel.font = [UIFont systemFontOfSize:11];
        refreshNormalHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
        refreshNormalHeader.stateLabel.textColor = [UIColor lightGrayColor];
        refreshNormalHeader.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    }
    self.mj_header .automaticallyChangeAlpha = YES;
    self.mj_footer.automaticallyChangeAlpha = YES;
     MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self footerWithRefreshing];
    }];
    autofooter.triggerAutomaticallyRefreshPercent = 0.8;
    self.mj_footer = autofooter;
    if ([self.mj_footer isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        MJRefreshBackNormalFooter * refreshBackNormalFooter =  (MJRefreshBackNormalFooter*)self.mj_footer;
        refreshBackNormalFooter.stateLabel.font = [UIFont systemFontOfSize:11];
        refreshBackNormalFooter.stateLabel.textColor = [UIColor lightGrayColor];
    }
}
- (void)headerWithRefreshing {
    if (self.tableDelegate &&[self.tableDelegate respondsToSelector:@selector(headerWithRefreshing)]) {
        [self.tableDelegate headerWithRefreshing];
    }
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01f;
}

-(void)footerWithRefreshing {
    if (self.tableDelegate &&[self.tableDelegate respondsToSelector:@selector(footerWithRefreshing)]) {
        [self.tableDelegate footerWithRefreshing];
    }
}
- (void)endRefreshing
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}

-(void)dealloc{
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
