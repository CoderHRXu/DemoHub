//
//  ResetPasswdFirstStepRequest.h
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "BaseRequest.h"

@interface ResetPasswdFirstStepRequest : BaseRequest

#pragma mark - input
/** 手机号  */
@property (nonatomic, strong) NSString *phone;
/** 验证码  */
@property (nonatomic, strong) NSString *code;

@end
