//
//  BSBaseCollectionView.h
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseCollectionViewDelegate <NSObject>

@optional

- (void)headerWithRefreshing;

-(void)footerWithRefreshing;

@end

@interface BSBaseCollectionView : UICollectionView

@property(nonatomic,weak)id<BaseCollectionViewDelegate> collectionDelegate;


/**
 添加刷新
 */
- (void)setMJRefreshHeaderFooter;

/**
 结束刷新
 */
- (void)endRefreshing;

@end
