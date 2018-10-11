//
//  SetUserTypeRequest.m
//  XiangFa
//
//  Created by Jeremy on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

#import "SetUserTypeRequest.h"

@implementation SetUserTypeRequest

- (NSString *)requestUrl {
    
    return @"v1/user/setUserType.json";
}

- (id)requestArgument {
    
    NSDictionary *dict =  @{
                            @"id" : @(self.ddtUserType)
                            };
    
    return [self mergeRequestArgument:dict];
}

- (NSDictionary *)mergeRequestArgument:(id)specificArguments {
    
    NSString *token                 =  self.token;
//    NSString *appVersion            =  CacheHandlerInstance.currentSetting.appVersion;
    NSString *appVersion            = @"x";
    NSMutableDictionary *commenInfoDic      =  [NSMutableDictionary dictionaryWithDictionary: @{
                                                                                                @"platform"          :@"ios",
                                                                                                @"app_version"       :appVersion,
                                                                                                @"os_version"        :[NSString stringWithFormat:@"%.2f", [UIDevice.currentDevice.systemVersion floatValue]],
                                                                                                @"phone_model"       :[Utils deviceVersion] ,
                                                                                                @"network_type"      :[NSNumber numberWithInt:[Utils getNetStatus]],
                                                                                                @"service_provider"  :[NSNumber numberWithInt:[Utils serviceProvider]],
                                                                                                @"session_token"     :token? :@"",
                                                                                                @"data"              :[NSNull null]
                                                                                                
                                                                                                }];
    
    if (specificArguments != nil) {
        
        commenInfoDic[@"data"]  = specificArguments;
    }
    
    return commenInfoDic;
}
@end
