//
//  CPSearchBarView.h
//  ChongDianZhuang
//
//  Created by ZL on 16/8/17.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CPSearchBarViewSelectedType) {
    CPSearchBarViewSelectedTypeCancel =100,
    CPSearchBarViewSelectedTypeOther
};

@class CPSearchBarView;
@protocol CPSearchBarViewDelegate <NSObject>
@optional
- (void)searchBarView:(CPSearchBarView *)searchBarView ShouldBeginEditing:(NSString *)searchText;

- (void)searchBarView:(CPSearchBarView *)searchBarView textDidChange:(NSString *)searchText;

- (void)searchBarView:(CPSearchBarView *)searchBarView textFieldDidEndEditing:(NSString *)searchText;
@optional
/**
 *  点击方法
 *
 *  @param searchBarView <#searchBarView description#>
 *  @param type          <#type description#>
 *  @param button        <#button description#>
 */
-(void)searchBarView:(CPSearchBarView *)searchBarView didSelectedWithType:(CPSearchBarViewSelectedType)type button:(UIButton *)button;

@end
@interface CPSearchBarView : UIView
/**
 *  代理
 */
@property(nonatomic,weak)id <CPSearchBarViewDelegate>delegate;

@property(nonatomic,copy)NSString *searchText;
/**
 *  取消第一响应
 */
-(void)resignFirstResponder;
@end
