//
//  ResetPasswdSecondStepRequest.h
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface ResetPasswdSecondStepRequest : BaseRequest

#pragma mark - input
/** 手机号  */
@property (nonatomic, strong) NSString *phone;
/** 验证码  */
@property (nonatomic, strong) NSString *validationCode;
/** 新密码  */
@property (nonatomic, strong) NSString *newpassword;
@end
