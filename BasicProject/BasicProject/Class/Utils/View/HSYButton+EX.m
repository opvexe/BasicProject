//
//  HSYButton+EX.m
//  SuperstarUser
//
//  Created by snowlu on 2017/10/18.
//  Copyright © 2017年 HSY. All rights reserved.
//

#import "HSYButton+EX.h"

@implementation HSYButton_EX

-(void)layoutSubviews{
    [super layoutSubviews];
    switch (self.type) {
        case ButtonDisplayTypeImageLeftTileRight:{
            self.titleLabel.x = 0;
            self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+5;
             break;
        }
        case ButtonDisplayTypeImageUpTileDown   :{
            self.imageView.y = 5;
            self.imageView.centerX = self.width * 0.5;
            self.titleLabel.y = self.height - self.titleLabel.height-5;
            [self.titleLabel sizeToFit]; // 文字长度自适应
            self.titleLabel.centerX = self.width * 0.5;
             break;
        }
        case ButtonDisplayTypeImageUpTile:{
                self.imageView.contentMode = UIViewContentModeCenter;
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
       
                self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
                self.titleLabel.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.height - self.frame.size.width);
    
            break;
        }
        default:{
              [super layoutSubviews];
        }
            break;
    }

}
@end
