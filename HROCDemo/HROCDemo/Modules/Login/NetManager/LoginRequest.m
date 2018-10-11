//
//  LoginRequest.m
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "LoginRequest.h"


@implementation LoginRequest

- (id)requestArgument {
    
    
   NSDictionary *dict =  @{
                           @"loginName":self.loginName,
                           @"password":self.password
                           };
    
    
    return [self mergeRequestArgument:dict];
}

- (NSString *)requestUrl {
    return  kNetPath_Login;
}

//请求结束前，解析返回的数据
- (void)requestSucceedPreprocessor {
    [super requestSucceedPreprocessor];
    
//    self.userInfoVo = [UserInfoVO mj_objectWithKeyValues:self.responseObject[@"data"]];
}

@end
