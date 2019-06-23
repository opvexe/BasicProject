//
//  CPSearchBarView.m
//  ChongDianZhuang
//
//  Created by ZL on 16/8/17.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import "CPSearchBarView.h"


@interface CPSearchBarView()<UITextFieldDelegate>
/**
 *  输入框
 */
@property (nonatomic, weak) UITextField * searchBarText;
@property(nonatomic,weak)UIButton *rightIconBT;
@property(nonatomic,weak)UIButton *cancelBT;
@property(nonatomic,weak)UIImageView *leftIconImageView;
@end

@implementation CPSearchBarView
-(instancetype)initWithFrame:(CGRect)frame{

  self =  [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];

        [self initView];
    }

    return self;
}
-(void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    self.searchBarText.text = searchText;
}
-(void)initView{

    UITextField *searchBarText = [[UITextField alloc] init];
    searchBarText.clearButtonMode =UITextFieldViewModeWhileEditing;
    searchBarText.rightViewMode =UITextFieldViewModeUnlessEditing;
    searchBarText.borderStyle = UITextBorderStyleNone;
    searchBarText.delegate =self;
    searchBarText.layer.cornerRadius = 15;
    searchBarText.layer.borderWidth = 0.5;
    searchBarText.layer.borderColor = lineBackgroundColor.CGColor;
    searchBarText.layer.backgroundColor = BaseViewControllerColor.CGColor;
    [self addSubview:searchBarText];
    searchBarText.placeholder = @"输入废品名称";
    searchBarText.font  = FontPingFangSC(15);
    [searchBarText becomeFirstResponder];
    [searchBarText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [searchBarText addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
    self.searchBarText =searchBarText;
    [searchBarText resignFirstResponder];
    UIImageView *leftIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];

    leftIconImageView.contentMode =UIViewContentModeScaleAspectFit;

    leftIconImageView.image = [UIImage imageNamed:@"precious_search_icon"];

    self.leftIconImageView =leftIconImageView;

    searchBarText.leftView = leftIconImageView;

    searchBarText.leftViewMode =UITextFieldViewModeAlways;

    UIButton *rightIconBT =[UIButton buttonWithType:UIButtonTypeCustom];

    rightIconBT.tag =CPSearchBarViewSelectedTypeOther;

    [rightIconBT setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];

    rightIconBT.frame =CGRectMake(0, 0, 12, 15);

    searchBarText.rightView =rightIconBT;

    [rightIconBT addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];

    self.rightIconBT = rightIconBT;
    

}
//FIXME  searchBarText 约束造成显示布局不对
-(void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *searchBarText =self.subviews.firstObject;
    searchBarText.frame = 
//    [searchBarText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self);
//        make.left.mas_equalTo(self).offset(10);
//        make.right.mas_equalTo(self).offset(-10);
//        make.bottom.mas_equalTo(self);
//    }];
    searchBarText.frame =  CGRectMake(10, 0, self.frame.size.width -20, self.frame.size.height);
    searchBarText.centerX = (self.width - 20) * 0.5;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBarText resignFirstResponder];
}
-(void)Click:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:didSelectedWithType:button:)]) {
        [self.delegate searchBarView:self didSelectedWithType:sender.tag button:sender];
    }

    [self.searchBarText resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:ShouldBeginEditing:)]) {

        [self.delegate searchBarView:self ShouldBeginEditing:textField.text];
    }

    return YES;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{


    [textField resignFirstResponder];

    return YES;

}


-(void)resignFirstResponder{

    [self.searchBarText resignFirstResponder];

}
-(void)textFieldDidEndEditing:(UITextField *)textField{



    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:textFieldDidEndEditing:)]) {

        [self.delegate searchBarView:self textFieldDidEndEditing:textField.text];
        
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:textDidChange:)]) {

        [self.delegate searchBarView:self textDidChange:textField.text];

    }

}
@end
