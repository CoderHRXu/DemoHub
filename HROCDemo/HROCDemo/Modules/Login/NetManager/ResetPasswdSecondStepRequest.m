//
//  ResetPasswdSecondStepRequest.m
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "ResetPasswdSecondStepRequest.h"

@implementation ResetPasswdSecondStepRequest

/**
 拼接参数
 */
- (id)requestArgument{
    
    NSDictionary *dict =  @{
                            @"phone"        :   self.phone,
                            @"phoneCode"    :   self.validationCode,
                            @"newPassword"  :   self.newpassword
                            };
    
    return [self mergeRequestArgument:dict];
}

/**
 请求URL
 */
- (NSString *)requestUrl{
    return  @"v1/user/restPassword.json";
}

@end
