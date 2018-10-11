//
//  SendVerificationCodeRequest.m
//  HROCDemo
//
//  Created by xuhaoran on 17/2/5.
//  Copyright © 2017年 RJS. All rights reserved.
//

#import "SendVerificationCodeRequest.h"

@implementation SendVerificationCodeRequest

/**
 拼接参数
 */
- (id)requestArgument{
    
    
    NSDictionary *dict =  @{@"phone":self.phone,
                            @"triggerScene":self.triggerScene};
    
    
    return [self mergeRequestArgument:dict];
}

/**
 请求URL
 */
- (NSString *)requestUrl{
    return  kNetPath_SendCode;
}

@end
