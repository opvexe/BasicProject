//
//  BSLoginModel.h
//  BellService
//
//  Created by snowlu on 2018/10/3.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import "BSBaseModel.h"

/**
 性别

 - LoginModelSexTypeFemale: LoginModelSexTypeFemale 女
 - LoginModelSexTypeMale: LoginModelSexTypeMale 男
 */
typedef NS_ENUM(NSUInteger, LoginModelSexType) {
    LoginModelSexTypeFemale,
    LoginModelSexTypeMale
};

/**
状态
 - LoginModelSexTypeNone: LoginModelSexTypeNone description
 - LoginModelSexTypeShielding: LoginModelSexTypeShielding 拉黑
 */
typedef NS_ENUM(NSUInteger, LoginModelStatusType) {
    LoginModelSexTypeNone,
    LoginModelSexTypeShielding
};
@interface BSLoginModel : BSBaseModel
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *nick_name;
@property(nonatomic,copy)NSString *company_id;
@property(nonatomic,copy)NSString *alliance_id;
@property(nonatomic,assign)LoginModelSexType sex;
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSString *birth_day;
@property(nonatomic,copy)NSString *profile_sign;
@property(nonatomic,copy)NSString *fans_count;
@property(nonatomic,copy)NSString *attention_count;
@property(nonatomic,copy)NSString *collect_count;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,copy)NSString *credits;
@property(nonatomic,copy)NSString *avatar_pic;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;
@property(nonatomic,copy)NSString *register_ip;
@property(nonatomic,copy)NSString *community_id;
@end
