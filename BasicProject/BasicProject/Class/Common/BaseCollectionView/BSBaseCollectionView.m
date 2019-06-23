//
//  BSBaseCollectionView.m
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseCollectionView.h"

@implementation BSBaseCollectionView

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
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self footerWithRefreshing];
    }];
    
    if ([self.mj_footer isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        MJRefreshBackNormalFooter * refreshBackNormalFooter =  (MJRefreshBackNormalFooter*)self.mj_footer;
        refreshBackNormalFooter.stateLabel.font = [UIFont systemFontOfSize:11];
        refreshBackNormalFooter.stateLabel.textColor = [UIColor lightGrayColor];
    }
}
- (void)headerWithRefreshing {
    if (self.collectionDelegate &&[self.collectionDelegate respondsToSelector:@selector(headerWithRefreshing)]) {
        [self.collectionDelegate headerWithRefreshing];
    }
}

-(void)footerWithRefreshing {
    if (self.collectionDelegate &&[self.collectionDelegate respondsToSelector:@selector(footerWithRefreshing)]) {
        [self.collectionDelegate footerWithRefreshing];
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
