//
//  BindClientIdRequest.m
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 04/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

#import "HandlePushClientIdRequest.h"

@implementation HandlePushClientIdRequest

//拼接参数
-(id)requestArgument {

    NSDictionary *arguments = @{
                                
                                @"clientId" : self.clientId?:@""
                                
                                };
    
    return [self mergeRequestArgument:arguments];
}

//接口路径
- (NSString *)requestUrl{
    
    if (self.isBind) {
    
        return kNetPath_BindClient;
    } else {
        
        return kNetPath_UnBindClient;
    }
}

- (BOOL)showHUD {
    return NO;
}

@end
