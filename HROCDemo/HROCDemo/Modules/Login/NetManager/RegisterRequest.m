//
//  RegisterRequest.m
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "RegisterRequest.h"
//#import "UserInfoVO.h"

@implementation RegisterRequest

/**
 拼接参数
 */
- (id)requestArgument {
    
    NSDictionary *dict =  @{@"phone"            : self.phone,
                            @"code"             : self.code,
                            @"password"         : self.password,
                            @"userType"         : @(self.userType),
                            @"invitationCode"   : self.invitationCode.length > 0 ? self.invitationCode : [NSNull null]
                            };
    return [self mergeRequestArgument:dict];
}

/**
 请求URL
 */
- (NSString *)requestUrl {
    return @"v1/user/appRegister.json";
}

/**
 请求结束前，解析返回的数据
 */
- (void)requestSucceedPreprocessor {
    [super requestSucceedPreprocessor];

//    self.userInfoVo                             = [UserInfoVO mj_objectWithKeyValues:self.responseObject[@"data"]];
}

@end
