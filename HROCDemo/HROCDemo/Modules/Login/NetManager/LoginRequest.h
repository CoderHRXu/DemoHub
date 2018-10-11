//
//  LoginRequest.h
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

#pragma mark - input
/** 用户名  */
@property (nonatomic, strong) NSString *loginName;
/** 密码  */
@property (nonatomic, strong) NSString *password;

#pragma mark - output
//output
//@property (nonatomic, strong) UserInfoVO *userInfoVo;

@end
