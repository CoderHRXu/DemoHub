//
//  RegisterRequest.h
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface RegisterRequest : BaseRequest

#pragma mark - input
/** 手机号  */
@property (nonatomic, strong) NSString *phone;
/** 验证码  */
@property (nonatomic, strong) NSString *code;
/** 密码  */
@property (nonatomic, strong) NSString *password;
/** 身份种类 */
@property (nonatomic, assign) NSInteger userType;
/** 推荐人/邀请码  */
@property (nonatomic, strong) NSString *invitationCode;
#pragma mark - output
//output
//@property (nonatomic, strong) UserInfoVO *userInfoVo;

@end
